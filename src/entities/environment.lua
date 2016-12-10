-- local gamestate = require "lib.gamestate"

local Environment = Class{}

function Environment:init()
    self.pos = {x = 0, y = 0}
    self.sprite = love.graphics.newImage("assets/images/spaceship_bridge_by_izacp-d9duao3.png")
end

function Environment:draw(dt)
	self.isEnvironment = true
    self.controllable = true
	-- this is where to place the background image

	love.graphics.setColor(255, 255, 0, 255)
    love.graphics.rectangle('fill', 0, 0, 1000, 2000)
    love.graphics.setColor(255, 255, 255)

    -- this is where environment related state is

end

return Environment
