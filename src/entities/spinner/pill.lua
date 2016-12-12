local Pill = Class{}

local Utils = require('Utils')

function Pill:init(number, color, v, pos, endX, padding, queue)
    self.color = color
    self.number = number
    self.spinner = true
    self.isPill = true
    self.velocity = v
    self.pos = pos
    self.endX = endX
    self.padding = padding
    self.queue = queue or 1
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
