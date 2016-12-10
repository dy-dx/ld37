-- local gamestate = require "lib.gamestate"
local anim8 = require '../../vendor/anim8'

local Explosion = Class{}

function Explosion:init(pos_x, pos_y)
    self.misslowcommand = true
    self.isExplosion = true
    self.isCollidable = true
    self.pos = {x = pos_x, y = pos_y}
    self.sprite = love.graphics.newImage('assets/tiles/explosion.png')
    self.velocity = {x = 0, y = 0}
    self.isDead = false
    self.timeTilDeath = .3

    local g = anim8.newGrid(50, 50, self.sprite:getWidth(), self.sprite:getHeight())
    self.animation = anim8.newAnimation(g('1-3', 1), 0.1)
    self.offset = {
        x = 50 / 2,
        y = 50 / 2,
    }
end

function Explosion:process(dt)
    self.timeTilDeath = self.timeTilDeath - dt
    if self.timeTilDeath <= 0 then
        self.isDead = true
    end
end

return Explosion
