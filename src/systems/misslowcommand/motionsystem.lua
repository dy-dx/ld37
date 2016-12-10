local Ship = require 'entities/misslowcommand/ship'
local Missile = require 'entities/misslowcommand/missile'

MisslowCommandSystem = tiny.processingSystem(Class{})

function MisslowCommandSystem:init()
    self.filter = tiny.requireAll('pos', 'velocity', 'process', 'isDead', 'misslowcommand')
    self.cooldown = 0
    math.randomseed(os.time())
end

function MisslowCommandSystem:preProcess(dt)
    if not self.ship then
        self.ship = true
        world:addEntity(Ship())
    end

    self.cooldown = self.cooldown - dt
    if self.cooldown <= 0 then
        self.cooldown = 5

        local wall = math.floor(math.random() * 4)
        local x, y
        if wall < 2 then
            x = math.random() * 800
            y = wall * 600
        else
            x = (wall - 2) * 800
            y = math.random() * 600
        end

        world:add(Missile(
            x, y,
            400, 300
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
