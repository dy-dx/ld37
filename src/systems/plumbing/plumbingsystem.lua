local Background = require 'entities/plumbing/background'
local CurvedPipe = require 'entities/plumbing/curvedpipe'
local StraightPipe = require 'entities/plumbing/straightpipe'

local FLUID_RATE = 0.4

function randomPipe(x, y)
    local pipeType = math.floor(math.random() * 6)
    if pipeType < 4 then
        return CurvedPipe(x, y, pipeType)
    else
        return StraightPipe(x, y, pipeType - 4)
    end
end

PlumbingSystem = tiny.processingSystem(Class{})

local DEBUG_MAP = {
    {" ", " ", " ", " ", " ", 3, "-", "-", "-", "-"},
    {" ", " ", " ", " ", " ", "|", 3, "-", 4, " "},
    {" ", " ", " ", " ", " ", "|", "|", "-", 1, " "},
    {" ", " ", " ", " ", " ", "|", 2, "-", "-", 4},
    {" ", " ", " ", " ", " ", 2, "-", "-", "-", 1},
    {" ", " ", " ", " ", " ", " ", " ", " ", " ", " "},
    {" ", " ", " ", " ", " ", " ", " ", " ", " ", " "}
}

function PlumbingSystem:init()
    self.pipes = {}
    self.filter = tiny.requireAll('pipeCoordinate', 'isDead', 'plumbing')
end

function PlumbingSystem:preProcess(dt)
    if not self.loaded then
        self.loaded = true

        world:addEntity(Background())
        for y=0,6 do
            for x=0,9 do
                local fromDebug = DEBUG_MAP[y + 1][x + 1]
                local pipe
                if fromDebug == " " then
                    pipe = randomPipe(x, y)
                elseif fromDebug == "-" then
                    pipe = StraightPipe(x, y, 0)
                elseif fromDebug == "|" then
                    pipe = StraightPipe(x, y, 1)
                else
                    pipe = CurvedPipe(x, y, fromDebug)
                end
                -- local pipe = randomPipe(x, y)
                -- local pipe = StraightPipe(x, y, 0)
                -- TODO: don't start here!!
                if pipe.pipeCoordinate.x == 9 and pipe.pipeCoordinate.y == 0 then
                    if not pipe:acceptFrom({x = 1, y = 0}) then
                        Signal.emit('gameover')
                    else
                        pipe.filling = true
                    end
                end
                world:addEntity(pipe)
            end
        end
    end
end

function PlumbingSystem:postProcess(dt)
end

function PlumbingSystem:process(e, dt)
    -- e:process(dt)

    if e.filling then
        e.fluidProgress = math.min(e.fluidProgress + dt * FLUID_RATE, 1)
        if e.fluidProgress == 1 then
            e.filling = false
            local outDir = e:outDirection()
            local coord = (e.pipeCoordinate.x + outDir.x) .. '_' .. (e.pipeCoordinate.y + outDir.y)

            local nextPipe = self.pipes[coord]
            if not nextPipe or not nextPipe:acceptFrom({x = -outDir.x, y = -outDir.y}) then
                Signal.emit('gameover')
                return
            end
            nextPipe.filling = true
            -- find the next guy to fill
        end
    end

    if e.isDead then
        world:remove(e)
    end
end

function PlumbingSystem:onAdd(e)
    local coord = e.pipeCoordinate.x .. '_' .. e.pipeCoordinate.y
    self.pipes[coord] = e
end

-- function PlumbingSystem:onRemove(e)

-- end

return PlumbingSystem
