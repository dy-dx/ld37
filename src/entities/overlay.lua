-- local gamestate = require "lib.gamestate"

local Overlay = Class{}

function Overlay:init()
    self.isOverlay = true;
end

function Overlay:draw(dt)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.rectangle('fill', 100, 100, 100, 100)
    love.graphics.setColor(255, 255, 255)
end

return Overlay
