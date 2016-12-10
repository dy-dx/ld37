MisslowCommandSystem = tiny.processingSystem(Class{})

function MisslowCommandSystem:init()
    self.filter = tiny.requireAll('pos', 'velocity', 'process', 'isDead', 'misslowcommand')
end

function MisslowCommandSystem:preProcess(dt)
end

function MisslowCommandSystem:postProcess(dt)
end

function MisslowCommandSystem:process(e, dt)
    e.pos.x = e.velocity.x * dt + e.pos.x
    e.pos.y = e.velocity.y * dt + e.pos.y

    e:process(dt)
    if e.isDead then
        world:remove(e)
    end
end

return MisslowCommandSystem
