local Pillbox = Class{}

local Utils = require('Utils')

function Pillbox:init(pos)
    self.spinner = true
    self.pos = pos
    self.isDead = false
    self.isDraw = true
end

function Pillbox:process(dt)
end

function Pillbox:draw(dt)
    Utils.printFilled({
        x = self.pos.x,
        y = self.pos.y,
        w = self.pos.w,
        h = self.pos.h
    },
    {
        r = 255,
        g = 0,
        b = 0,
        a = 255
    })
end

return Pillbox
