-- local gamestate = require "lib.gamestate"

local Ship = Class{}
start_x = 400
start_y = 300

function Ship:init()
    self.misslowcommand = true
    self.isDead = false

    self.pos = {x = start_x, y = start_y}
    self.sprite = love.graphics.newImage('assets/images/ship.png')

    self.offset = {
        x = self.sprite:getWidth() / 2,
        y = self.sprite:getHeight() / 2,
    }
end

function Ship:process(dt)
end

return Ship
