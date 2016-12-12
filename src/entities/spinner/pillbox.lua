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
    return table.getn(self.pills) == self.pillboxMaxSize
end

function Pillbox:addPill(pillNumber, pillColor)
    local pill = Pill(pillNumber, self:getPillPosition(), pillColor)
    lume.push(self.pills, pill)
end

function Pillbox:getPillPosition()
    local pillSlotWidth = (self.pos.w) / self.maxPills;

    return {
        x = self.pos.x + pillSlotWidth * ( table.getn(self.pills)) + self.padding,
        y = self.pos.y,
        w = pillSlotWidth - 2 * self.padding,
        h = self.pos.h
    }
end

function Pillbox:removePill()
    world:remove(lume.first(self.pills))
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
        pill.render(i)
        i = i + 1
    end)

end

return Pillbox
