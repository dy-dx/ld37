local Pill = Class{}

local Utils = require('Utils')

function Pill:init(number, color)
    self.color = color
    self.number = number
end

function Pill:render(pos)
    Utils.printFilled({
        x = self.pos.x,
        y = self.pos.y,
        w = self.pos.w,
        h = self.pos.h
    },
    self.color or { r = 0, g = 0 , b = 255, a = 255})
end

return Pill
