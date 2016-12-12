-- local gamestate = require "lib.gamestate"
local anim8 = require 'vendor/anim8'
local Utils = (require 'utils')()
local Explosion = require 'entities/misslowcommand/explosion'

local Shell = Class{}
Shell.SPEED = 120
start_x = 400
start_y = 300

function Shell:init(dest_x, dest_y)
    self.misslowcommand = true
    self.isShell = true
    self.destination = {x = dest_x, y = dest_y}
    self.isDead = false

    local offset_x = dest_x - start_x
    local offset_y = dest_y - start_y
    angle = math.atan2(offset_y, offset_x)

    self.velocity = {
        x = math.cos(angle) * Shell.SPEED,
        y = math.sin(angle) * Shell.SPEED,
    }
    self.pos = {x = start_x, y = start_y}
    self.sprite = love.graphics.newImage('assets/images/bomb_sheet.png')
    self.target_sprite = love.graphics.newImage('assets/images/target.png')

    local g = anim8.newGrid(20, 20, self.sprite:getWidth(), self.sprite:getHeight())
    self.animation = anim8.newAnimation(g('1-2', 1), 0.1)
    self.offset = {
        x = 20 / 2,
        y = 20 / 2,
    }
end

function Shell:process(dt)
    local ox = self.pos.x - self.destination.x
    local oy = self.pos.y - self.destination.y
    -- if ox * ox + oy * oy < dt * Shell.SPEED * dt * Shell.SPEED then
    if Utils.isInCircle(ox, oy, dt * Shell.SPEED) then
        world:addEntity(Explosion(self.destination.x, self.destination.y))
        self.isDead = true
    end
end

function Shell:draw(dt)
    love.graphics.draw(self.target_sprite,
        self.destination.x, self.destination.y, 0, 1, 1, 8, 8)
end
return Shell
