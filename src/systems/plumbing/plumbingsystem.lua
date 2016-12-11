local Pipe = require 'entities/plumbing/pipe'

PlumbingSystem = tiny.processingSystem(Class{})

function PlumbingSystem:init()
    self.filter = tiny.requireAll('process', 'isDead', 'plumbing')
end

function PlumbingSystem:preProcess(dt)
    if not self.pipes then
        self.pipes = true
        for y=0,6 do
            for x=0,9 do
                world:addEntity(Pipe(x, y, math.floor(math.random() * 4)))
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
