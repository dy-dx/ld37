local Indicator = require 'entities/spinner/indicator'
local SpinnerFrame = require 'entities/spinner/spinnerframe'
local Pillbox = require 'entities/spinner/pillbox'
local Pill = require 'entities/spinner/pill'

SpinnerSystem = tiny.processingSystem(Class{})

function SpinnerSystem:init()
    self.filter = tiny.requireAll('process', 'isDead', 'spinner')
    self.cooldown = 0
    self.pillboxLoc = { x = 450, y = 300, w = 200, h = 50 }
    self.pillboxMaxSize = 5
    self.pillPadding = 5
    self.numPills = 0;
end

function SpinnerSystem:preProcess(dt)
    if not self.indicator then
        self.indicator = true
        world:addEntity(Indicator())
        world:addEntity(SpinnerFrame())
        world:addEntity(Pillbox(self.pillboxLoc))
    end

    self.cooldown = self.cooldown - dt
    if self.cooldown <= 0 then
        self.cooldown = 5

        if(self.numPills == self.pillboxMaxSize) then
            Signal.emit('gameover')
            return;
        end
        self.numPills = self.numPills + 1

        local pillPosition = self:getPillPosition()

        world:addEntity(Pill(pillPosition))
    end
end

function SpinnerSystem:postProcess(dt)
end

function SpinnerSystem:getPillPosition()
    local pillSlotWidth = (self.pillboxLoc.w) / self.pillboxMaxSize;

    return {
        x = self.pillboxLoc.x + pillSlotWidth * ( self.numPills - 1) + self.pillPadding,
        y = self.pillboxLoc.y,
        w = pillSlotWidth - 2 * self.pillPadding,
        h = self.pillboxLoc.h
    }
end

function SpinnerSystem:process(e, dt)
    -- e.pos.x = e.velocity.x * dt + e.pos.x
    -- e.pos.y = e.velocity.y * dt + e.pos.y


    e:process(dt)
    if e.isDead then
        world:remove(e)
    end
end

return SpinnerSystem
