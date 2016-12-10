-- local gamestate = require "lib.gamestate"

local Environment = Class{}

function Environment:init()
    self.global = true
    self.pos = {x = 0, y = 0}
    self.sprite = love.graphics.newImage("assets/images/background.png")
end

function Environment:draw(dt)
	self.isEnvironment = true
    self.controllable = true
end

return Environment
