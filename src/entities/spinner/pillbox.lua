local Pillbox = Class{}

local Utils = require('utils')
local Pill = require('entities/spinner/pill')

function Pillbox:init(pos, maxPills, padding)
    self.spinner = true
    self.pos = pos
    self.isDead = false
    self.isDraw = true
    self.pills = {}
    self.sprite = love.graphics.newImage('assets/images/pills/tube.png')
    self.alpha = 0.6
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

    local pillStartX = self.pos.x - pillWidth + 10

    local pill = Pill(
        pillNumber,
        pillColor,
        50,
        {
            x = pillStartX,
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

return Pillbox
