local Background = require 'entities/plumbing/background'
local CurvedPipe = require 'entities/plumbing/curvedpipe'
local StraightPipe = require 'entities/plumbing/straightpipe'

PlumbingSystem = tiny.processingSystem(Class{})

function PlumbingSystem:init()
    self.filter = tiny.requireAll('process', 'isDead', 'plumbing')
end

function PlumbingSystem:preProcess(dt)
    if not self.pipes then
        self.pipes = true

        world:addEntity(Background())
        for y=0,6 do
            for x=0,9 do
                local pipeType = math.floor(math.random() * 6)
                if pipeType < 4 then
                    world:addEntity(CurvedPipe(x, y, pipeType))
                else
                    world:addEntity(StraightPipe(x, y, pipeType - 4))
                end
            end
        end
    end
end

function PlumbingSystem:postProcess(dt)
end

function PlumbingSystem:process(e, dt)
    e:process(dt)
    if e.isDead then
        world:remove(e)
    end
end

return PlumbingSystem
