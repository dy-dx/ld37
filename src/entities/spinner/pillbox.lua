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
    local pill = Pill(pillNumber, pillColor)
    lume.push(self.pills, pill)
end

function Pillbox:getPillPosition(num)
    local pillSlotWidth = (self.pos.w) / self.maxPills;

    return {
        x = self.pos.x + pillSlotWidth * (num - 1) + self.padding,
        y = self.pos.y,
        w = pillSlotWidth - 2 * self.padding,
        h = self.pos.h
    }
end

function Pillbox:removePill()
    table.remove(self.pills, 1)
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

    local i = 1
    lume.each(self.pills, function(pill)
        local position = self:getPillPosition(i);
        pill:render(position)
        i = i + 1
    end)

end

return Pillbox
