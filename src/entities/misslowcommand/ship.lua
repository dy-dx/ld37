-- local gamestate = require "lib.gamestate"
local anim8 = require '../../vendor/anim8'

local Ship = Class{}
start_x = 400
start_y = 300

function Ship:init()
    self.misslowcommand = true
    self.isDead = false

    self.pos = {x = start_x, y = start_y}
    self.sprite = love.graphics.newImage('assets/images/ship_sheet.png')

    local g = anim8.newGrid(50, 45, self.sprite:getWidth(), self.sprite:getHeight())
    self.animation = anim8.newAnimation(g('1-2', 1), 0.1)
    self.offset = {
        x = 50 / 2,
        y = 45 / 2,
    }
end

function Ship:process(dt)
end

return Ship
