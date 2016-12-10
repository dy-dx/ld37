-- local gamestate = require "lib.gamestate"

local Utils = require('utils');

local Overlay = Class{}

function Overlay:init(hitbox, closeHitboxes)

    local windowWidth  = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()
    local padding = 40;
    local closeRadius = 20;
    local largCloseButtonWidth = 300;
    local largCloseButtonHeight = 20;

    self.isOverlay = true;
    self.hitbox = {
        x = padding,
        y = padding,
        w = windowWidth - 2 * padding,
        h = windowHeight - 2 * padding * 1.5
    }

    self.closeHitboxes = {
        {
            x = windowWidth - padding - closeRadius,
            y = padding - closeRadius,
            w = closeRadius * 2,
            h = closeRadius * 2
        },
        {
            x = 100,
            y = windowHeight - 2 * padding,
            w = 600,
            h = 200
        }
    }
end

function Overlay:draw(dt)
    Utils.printFilled(self.hitbox, {r = 0, g = 255, b = 0, a = 255})

    lume.each(self.closeHitboxes, function(cHitbox)
        Utils.printFilled(cHitbox, {r = 255, g = 0, b = 0, a = 255})
    end)
end

return Overlay
