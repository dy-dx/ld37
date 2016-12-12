local Pillbox = Class{}

local Utils = require('Utils')
local Pill = require('entities/spinner/pill')

function Pillbox:init(pos, maxPills, padding)
    self.spinner = true
    self.pos = pos
    self.isDead = false
    self.isDraw = true
    self.pills = {}

    self.maxPills = maxPills
    self.padding = padding
end

function Pillbox:process(dt)
end

function Pillbox:isFull(dt)
    return table.getn(self.pills) == self.maxPills
end

function Pillbox:addPill(pillNumber, pillColor)

    local pillWidth = (self.pos.w)/self.maxPills

    local pill = Pill(
        pillNumber,
        pillColor,
        30,
        {
            x = self.pos.x,
            y = self.pos.y,
            w = pillWidth - 2 * self.padding,
            h = self.pos.h
        },
        self.pos.x + self.pos.w - pillWidth,
        self.padding,
        table.getn(self.pills) + 1)
    lume.push(self.pills, pill)
    return pill
end

function Pillbox:removePill()
    self.pills = lume.map(self.pills, function(pill)
        pill.queue = pill.queue - 1
        return pill
    end)
    return table.remove(self.pills, 1)
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
