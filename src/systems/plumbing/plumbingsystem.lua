local Background = require 'entities/plumbing/background'
local StartBuffer = require 'entities/plumbing/startbuffer'
local CurvedPipe = require 'entities/plumbing/curvedpipe'
local StraightPipe = require 'entities/plumbing/straightpipe'

local FLUID_RATE = 0.1
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

function getPipeKey(x, y)
    return x .. '_' .. y
end

PlumbingSystem = tiny.processingSystem(Class{})

function PlumbingSystem:init()
    Global.pipes = {}
    self.filter = tiny.requireAll('isDead', 'outDirection', 'plumbing')
end

function PlumbingSystem:preProcess(dt)
    if not self.loaded then
        self.loaded = true

        world:addEntity(Background())
        world:addEntity(StartBuffer())
        -- Scrap pipe
        world:addEntity(randomPipe(11, 5))
        for y=0,6 do
            for x=1,9 do
                local pipe = randomPipe(x, y)
                world:addEntity(pipe)
            end
        end
    end
end

function PlumbingSystem:postProcess(dt)
end

function PlumbingSystem:process(e, dt)
    if e.filling then
        e.fluidProgress = math.min(e.fluidProgress + dt * (e.fluidRate or FLUID_RATE), 1)
        if e.fluidProgress == 1 then
            e.filling = false
            local outDir = e:outDirection()
            local key = getPipeKey(outDir.x, outDir.y)

            -- find the next pipe to fill
            local nextPipe = Global.pipes[key]
            if not nextPipe or not nextPipe:acceptFrom({x = -outDir.dx, y = -outDir.dy}) then
                Signal.emit('gameover')
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
