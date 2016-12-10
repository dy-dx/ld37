local Missile = require 'entities/misslowcommand/missile'

MisslowCommandSystem = tiny.processingSystem(Class{})

function MisslowCommandSystem:init()
    self.filter = tiny.requireAll('pos', 'velocity', 'process', 'isDead', 'misslowcommand')
    self.cooldown = 0
    math.randomseed(os.time())
end

function MisslowCommandSystem:preProcess(dt)
    self.cooldown = self.cooldown - dt
    if self.cooldown <= 0 then
        self.cooldown = 5
        world:add(Missile(
            math.random() * 800, -30,
            math.random() * 800, 550
        ))
    end
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
