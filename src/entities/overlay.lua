-- local gamestate = require "lib.gamestate"

local Utils = require('utils');

local Overlay = Class{}

function Overlay:init(hitbox, closeHitboxes)
    self.isOverlay = true;
    self.hitbox = hitbox;
    self.closeHitboxes = closeHitboxes;
end

function Overlay:draw(dt)
    Utils.printFilled(self.hitbox, {r = 0, g = 255, b = 0, a = 255})

    lume.each(self.closeHitboxes, function(cHitbox)
        Utils.printFilled(cHitbox, {r = 255, g = 0, b = 0, a = 255})
    end)
end

return Overlay
