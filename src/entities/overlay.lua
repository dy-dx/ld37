-- local gamestate = require "lib.gamestate"

local Overlay = Class{}

function Overlay:init()
    self.isOverlay = true
    local windowWidth  = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()
    local padding = 40
    local bottomPadding = 120
    self.hitbox = {
        x = padding,
        y = padding,
        w = windowWidth - 2 * padding,
        h = windowHeight - bottomPadding
    }
end

function Overlay:draw(dt)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.rectangle('fill', self.hitbox.x, self.hitbox.y, self.hitbox.w, self.hitbox.h)
    love.graphics.setColor(255, 255, 255)
end

return Overlay
