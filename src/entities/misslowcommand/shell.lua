-- local gamestate = require "lib.gamestate"
local Explosion = require 'entities/misslowcommand/explosion'

local Shell = Class{}
Shell.SPEED = 60
start_x = 400
start_y = 500

function Shell:init(dest_x, dest_y)
    self.misslowcommand = true
    self.isShell = true
    self.destination = {x = dest_x, y = dest_y}
    self.isDead = false

    local offset_x = dest_x - start_x
    local offset_y = dest_y - start_y
    local total_hypotenuse = math.sqrt(offset_x * offset_x + offset_y * offset_y)
    angle = math.atan2(offset_y, offset_x)

    self.velocity = {
        x = math.cos(angle) * Shell.SPEED,
        y = math.sin(angle) * Shell.SPEED,
    }
    self.pos = {x = start_x, y = start_y}
    self.sprite = love.graphics.newImage('assets/images/bullet.png')
    self.offset = {
        x = self.sprite:getWidth() / 2,
        y = self.sprite:getHeight() / 2,
    }
end

function Shell:process(dt)
    local ox = self.pos.x - self.destination.x
    local oy = self.pos.y - self.destination.y
    if ox * ox + oy * oy < dt * Shell.SPEED * dt * Shell.SPEED then
        print "BOOM"
        world:addEntity(Explosion(self.destination.x, self.destination.y))
        self.isDead = true
    end
end

return Shell
