local Pill = Class{}

local Utils = require('Utils')

function Pill:init(pos, color)
    self.spinner = true
    self.color = color
    self.pos = pos
    self.isDead = false
end

function Pill:process(dt)
end

function Pill:draw(dt)
    Utils.printFilled({
        x = self.pos.x,
        y = self.pos.y,
        w = self.pos.w,
        h = self.pos.h
    },
    self.color or { r = 0, g = 0 , b = 255, a = 255})
end

return Pill
