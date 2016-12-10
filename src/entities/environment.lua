-- local gamestate = require "lib.gamestate"

local Environment = Class{}

function Environment:init()
    self.pos = {x = 0, y = 0}
    self.sprite = love.graphics.newImage("assets/images/spaceship_bridge_by_izacp-d9duao3.png")
end

function Environment:draw(dt)
end

return Environment
