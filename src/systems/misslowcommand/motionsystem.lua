local Background = require 'entities/misslowcommand/background'
local Ship = require 'entities/misslowcommand/ship'
local Missile = require 'entities/misslowcommand/missile'

MisslowCommandSystem = tiny.processingSystem(Class{})

local TIME_TO_MISSILE = 5  -- seconds

local MISSILE_LENGTH = 35
local WIDTH = 720
local HEIGHT = 480
local OFFSET = 40

function MisslowCommandSystem:init()
    self.filter = tiny.requireAll('pos', 'velocity', 'process', 'isDead', 'misslowcommand')
    self.cooldown = 0
    math.randomseed(os.time())
end

function MisslowCommandSystem:preProcess(dt)
    if not self.ship then
        self.ship = true
        world:addEntity(Background())
        world:addEntity(Ship())
    end

    self.cooldown = self.cooldown - dt
    if self.cooldown <= 0 then
        self.cooldown = TIME_TO_MISSILE

        local wall = math.floor(math.random() * 4)
        local x, y

        if wall < 2 then
            x = math.random() * (WIDTH - MISSILE_LENGTH) + OFFSET + MISSILE_LENGTH / 2
            y = wall * (HEIGHT - MISSILE_LENGTH) + OFFSET + MISSILE_LENGTH / 2
        else
            x = (wall - 2) * (WIDTH - MISSILE_LENGTH) + OFFSET + MISSILE_LENGTH / 2
            y = math.random() * (HEIGHT - MISSILE_LENGTH) + OFFSET + MISSILE_LENGTH / 2
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
