local Indicator = require 'entities/spinner/indicator'
local SpinnerFrame = require 'entities/spinner/spinnerframe'

SpinnerSystem = tiny.processingSystem(Class{})

function SpinnerSystem:init()
    self.filter = tiny.requireAll('process', 'isDead', 'spinner')
end

function SpinnerSystem:preProcess(dt)
    if not self.indicator then
        print("why god")
        self.indicator = true
        world:addEntity(Indicator())
        world:addEntity(SpinnerFrame())
    end

    -- if not self.ship then
    --     self.ship = true
    --     world:addEntity(Ship())
    -- end
end

function SpinnerSystem:postProcess(dt)
end

function SpinnerSystem:process(e, dt)
    -- e.pos.x = e.velocity.x * dt + e.pos.x
    -- e.pos.y = e.velocity.y * dt + e.pos.y

    e:process(dt)
    if e.isDead then
        world:remove(e)
    end
end

return SpinnerSystem
