local Pill = Class{}

local Utils = require('Utils')

function Pill:init(number, color)
    self.color = color
    self.number = number
end

function Pill:render(pos)
    Utils.printFilled({
        x = pos.x,
        y = pos.y,
        w = pos.w,
        h = pos.h
    },
    self.color or { r = 0, g = 0 , b = 255, a = 255})
end

return Pill
