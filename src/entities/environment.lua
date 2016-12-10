-- local gamestate = require "lib.gamestate"

local Environment = Class{}
local Panel = require 'entities/panel'


function Environment:init()
	self.isEnvironment = true
	self.currentPanel = Panel()
end

function Environment:draw(dt)

	love.graphics.setColor(255, 255, 0, 255)
    love.graphics.rectangle('fill', 0, 0, 1000, 2000)
    love.graphics.setColor(255, 255, 255)

    self.currentPanel:draw(dt)
end

return Environment
