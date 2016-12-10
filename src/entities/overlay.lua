-- local gamestate = require "lib.gamestate"

local Overlay = Class{}

function Overlay:init(hitbox)
    self.isOverlay = true;
    self.hitbox = hitbox;
end

function Overlay:draw(dt)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.rectangle('fill', self.hitbox.x, self.hitbox.y, self.hitbox.w, self.hitbox.h)
    love.graphics.setColor(255, 255, 255)
end

return Overlay
