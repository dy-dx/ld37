-- local gamestate = require "lib.gamestate"

local Utils = require('utils');

local Overlay = Class{}

local windowWidth  = love.graphics.getWidth()
local windowHeight = love.graphics.getHeight()

function Overlay:init(hitbox, closeHitboxes)
    local padding = 40;
    local closeRadius = 20;
    local largCloseButtonWidth = 300;
    local largCloseButtonHeight = 20;

    self.sprite = love.graphics.newImage("assets/images/chrome.png")


    self.isOverlay = true;
    self.hitbox = {
        x = padding,
        y = padding,
        w = windowWidth - 2 * padding,
        h = windowHeight - 2 * padding * 1.5
    }

    self.pos = { x = self.hitbox.x, y = self.hitbox.y }
end

function Overlay:draw(dt)
    love.graphics.draw(
        self.sprite,
        self.hitbox.x,
        self.hitbox.y,
        0,
        self.hitbox.w/self.sprite:getWidth(),
        self.hitbox.h/self.sprite:getHeight(),
        0,
        0)

    -- Utils.printFilled(self.hitbox, {r = 255, g = 255, b = 255, a = 255}, 'fill')
    -- love.graphics.draw(self.sprite, self.hitbox.x, self.hitbox.y, 0, 1, 1, 0, 0)
end

return Overlay
