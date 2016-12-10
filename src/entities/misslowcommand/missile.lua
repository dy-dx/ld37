-- local gamestate = require "lib.gamestate"

local Missile = Class{}
Missile.SPEED = 60

function Missile:init(src_x, src_y, dest_x, dest_y)
    self.misslowcommand = true
    self.isMissile = true
    self.isCollidable = true
    self.destination = {x = dest_x, y = dest_y}
    self.isDead = false

    local offset_x = dest_x - src_x
    local offset_y = dest_y - src_y
    self.rot = math.atan2(offset_y, offset_x)

    self.velocity = {
        x = math.cos(self.rot) * Missile.SPEED,
        y = math.sin(self.rot) * Missile.SPEED,
    }
    self.pos = {x = src_x, y = src_y}
    self.sprite = love.graphics.newImage('assets/images/missile.png')
    self.offset = {
        x = self.sprite:getWidth() / 2,
        y = self.sprite:getHeight() / 2,
    }
end

function Missile:process(dt)
    local ox = self.pos.x - self.destination.x
    local oy = self.pos.y - self.destination.y
    if ox * ox + oy * oy < dt * Missile.SPEED * dt * Missile.SPEED then
        self.isDead = true
    end
end

return Missile
