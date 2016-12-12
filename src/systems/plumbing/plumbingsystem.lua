local Utils = require 'utils'

local Background = require 'entities/plumbing/background'
local EndBuffer = require 'entities/plumbing/endbuffer'
local StartBuffer = require 'entities/plumbing/startbuffer'
local CurvedPipe = require 'entities/plumbing/curvedpipe'
local StraightPipe = require 'entities/plumbing/straightpipe'

-- DIFFICULTY PARAMS
local FLUID_RATE = 0.1  -- Larger number -> faster flow. See also startBuffer.fluidRate
local WARNING_PIPES = 1  -- Number of pipes ahead of current one to trigger WARNING
local DANGER_PIPES = 0
local RESTART_ON_WIN = true  -- Reshuffle board when game is won. Otherwise, just leave "won"

-- OK DON'T TOUCH THESE ANYMORE
local OFFSET_X = 127
local OFFSET_Y = 120

function randomPipe(x, y)
    local pipeType = math.floor(math.random() * 6)
    if pipeType < 4 then
        return CurvedPipe(x, y, OFFSET_X, OFFSET_Y, pipeType)
    else
        return StraightPipe(x, y, OFFSET_X, OFFSET_Y, pipeType - 4)
    end
end

function pipeAtMouse()
    local x, y = love.mouse.getPosition()
    x = math.floor((x - 100) / 50)
    y = math.floor((y - 100) / 50)
    local key = getPipeKey(x, y)
    return Global.pipes[key]
end

function getPipeKey(x, y)
    return x .. '_' .. y
end

PlumbingSystem = tiny.processingSystem(Class{})

function restartLevel()
    -- the PlumbingSystem is smart enough to clean up after itself as new stuff comes up

    if not Utils.has_value(Global.currentLevelDefinition.activeGames, 'plumbing') then
        return
    end
    world:addEntity(Background())
    world:addEntity(StartBuffer())
    world:addEntity(EndBuffer())
    -- Scrap pipe
    world:addEntity(randomPipe(11, 5))
    for y=0,6 do
        for x=1,9 do
            local pipe = randomPipe(x, y)
            world:addEntity(pipe)
        end
    end
end

Signal.register('startLevel', restartLevel)

function PlumbingSystem:init()
    self.filter = tiny.requireAll('isDead', 'plumbing')
    Global.pipes = {}
    self.singletons = {}
end

function PlumbingSystem:preProcess(dt)
end

function PlumbingSystem:postProcess(dt)
end

function healthCheck(currentPipe)
    -- Do a quick lookahead to see how many pipes we can traverse.
    for i=0,WARNING_PIPES do
        local outDir = currentPipe:outDirection()

        -- clear path to the goal
        if outDir.x == 0 and outDir.y == 6 then
            return 1  -- SAFE
        end
        local key = getPipeKey(outDir.x, outDir.y)
        currentPipe = Global.pipes[key]
        if not currentPipe or not currentPipe:acceptFrom({x = -outDir.dx, y = -outDir.dy}) then
            if i <= DANGER_PIPES then
                return 3  -- DANGER
            end
            return 2  -- WARNING
        end
    end
    return 1  -- SAFE
end

function PlumbingSystem:process(e, dt)
    if e == pipeAtMouse() and not e.lifted then
        e.highlighted = true
    else
        e.highlighted = false
    end
    if e.filling then
        Signal.emit('dangerLevel', 'plumbing', healthCheck(e))

        -- Actually move the fluid.
        e.fluidProgress = math.min(e.fluidProgress + dt * (e.fluidRate or FLUID_RATE), 1)
        if e.fluidProgress == 1 then
            e.filling = false
            if e.type == 'endbuffer' then
                if RESTART_ON_WIN then
                    restartLevel()
                end
                return
            end
            local outDir = e:outDirection()

            -- Gross hardcode! It's Sunday night!
            if outDir.x == 0 and outDir.y == 6 then
                self.singletons['endbuffer'].filling = true
                return
            end

            local key = getPipeKey(outDir.x, outDir.y)

            -- find the next pipe to fill
            local nextPipe = Global.pipes[key]
            if not nextPipe or not nextPipe:acceptFrom({x = -outDir.dx, y = -outDir.dy}) then
                Signal.emit('gameover', 'plumbing')
                return
            end
            nextPipe.filling = true
        end
    end

    if e.isDead then
        world:remove(e)
    end
end

function PlumbingSystem:onAdd(e)
    if not e.pipeCoordinate then
        if self.singletons[e.type] then
            world:remove(self.singletons[e.type])
        end
        self.singletons[e.type] = e
        return
    end
    local key = getPipeKey(e.pipeCoordinate.x, e.pipeCoordinate.y)
    local existingPipe = Global.pipes[key]
    if existingPipe then
        world:remove(existingPipe)
    end
    Global.pipes[key] = e
end

return PlumbingSystem
