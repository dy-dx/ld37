-- local gamestate = require "lib.gamestate"

local Panel1 = Class{}

function Panel1:init()
	self.isPanel = true
end

function Panel1:draw(dt)

	print("panel draw called")
	print(dt)

	love.graphics.setColor(0, 255, 0, 255)
    love.graphics.rectangle('fill', 30, 40, 1000, 2000)
    love.graphics.setColor(255, 255, 255)
end

return Panel1
