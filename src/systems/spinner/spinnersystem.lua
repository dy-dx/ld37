local Indicator = require 'entities/spinner/indicator'
local SpinnerFrame = require 'entities/spinner/spinnerframe'
local Pillbox = require 'entities/spinner/pillbox'
local Pill = require 'entities/spinner/pill'

SpinnerSystem = tiny.processingSystem(Class{})

function SpinnerSystem:init()
    self.filter = tiny.requireAll('process', 'isDead', 'spinner')
    self.cooldown = 0

    self.name = "spinner"
    self.filter = tiny.requireAll('isIndicator')
    self.input = Input()
    self.input:bind('mouse1', 'mouse1')
end

function SpinnerSystem:preProcess(dt)
    if not self.indicator then
        self.indicator = Indicator()
        self.pillBox = Pillbox({ x = 450, y = 300, w = 200, h = 50 }, 5, 5)
        world:addEntity(self.indicator)
        world:addEntity(SpinnerFrame())
        world:addEntity(self.pillBox)
    end

    self.cooldown = self.cooldown - dt
    if self.cooldown <= 0 then
        self.cooldown = 5

        if(self.pillBox:isFull()) then
            Signal.emit('gameover')
            return;
        end

        local pillNumber = math.random(table.getn(self.indicator.colors))

        local pillColor = self.indicator.colors[pillNumber]


        self.pillBox:addPill(pillNumber, pillColor)

    end
end

function SpinnerSystem:postProcess(dt)
end

function SpinnerSystem:process(e, dt)

    if Global.currentGame ~= self.name then return end

    e:process(dt)
    if e.isDead then
        world:remove(e)
    end

    if self.input:released("mouse1") then
        if(0 == table.getn(self.pillBox.pills)) then return end

        if(lume.first(self.pillBox.pills).number == self.indicator:getSelected()) then
            self.pillBox:removePill()
        end
    end
end

return SpinnerSystem
