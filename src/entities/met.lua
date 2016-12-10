-- local gamestate = require "lib.gamestate"

local Met = Class{}

function Met:init(x, y, target)
    self.sprite = love.graphics.newImage('assets/images/met_sample_sprite_left.png')

    -- these are all copied from that demo project
    -- this doesn't do anything yet

    self.pos = {x = x, y = y}
    self.vel = {x = 0, y = 0}
    self.gravity = 1300

    self.isAlive = true
    self.isEnemy = true
    self.isSolid = true

    self.platforming = {
        acceleration = 1000,
        speed = 60,
        jump = 250,
        friction = 2000,
        direction = 'r'
    }

    self.ai = {

    }

    self.debugHitbox = true
    self.hitbox = {x = 0, y = 0, w = 12, h = 12}
    self.health = 50
    self.maxHealth = 50

    self.fg = true
end

function Met:gotHit()
    if self.isAlive then
        self.isAlive = nil
        self.lifetime = 0.25
        self.fadeTime = 0.25
        self.alpha = 1
        self.ai = nil
        self.platforming.moving = false
        self.vel.y = -300
        self.vel.x = 0
        world:add(self)
        -- gamestate.current().score = gamestate.current().score + 1
    end
end

return Met
