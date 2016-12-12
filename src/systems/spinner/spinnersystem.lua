local SpinnerFrame = require 'entities/spinner/spinnerframe'
local Pillbox = require 'entities/spinner/pillbox'
local Pill = require 'entities/spinner/pill'
local Background = require 'entities/spinner/background'
local Utils = require 'utils'

SpinnerSystem = tiny.processingSystem(Class{})

function SpinnerSystem:init()
    self.filter = tiny.requireAll('process', 'isDead', 'spinner', 'isSpinnerFrame')
    self.cooldown = 0

    self.name = "spinner"
    self.input = Input()
    self.input:bind('mouse1', 'mouse1')
    self.pillBox = nil
    self.spinnerPos = { x = 480, y = 270 }
end

function SpinnerSystem:preProcess(dt)
    if not self.spinnerFrame then
        self.spinnerFrame = SpinnerFrame(self.spinnerPos)
        self.pillBox = Pillbox({ x = 90, y = 240, w = 280, h = 60 }, 5, 5)
        world:addEntity(Background())
        world:addEntity(self.spinnerFrame)
        world:addEntity(self.pillBox)
    end

    self.cooldown = self.cooldown - dt
    if self.cooldown <= 0 then
        self.cooldown = 5

        if(self.pillBox:isFull()) then
            Signal.emit('gameover')
            return;
        end

        local pillNumber = math.random(table.getn(self.spinnerFrame.colors))
        local pillColor = self.spinnerFrame.colors[pillNumber]
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
        clickX, clickY = love.mouse.getPosition()
        local position = {x = clickX, y = clickY}
        local spinnerBox = {x = self.spinnerPos.x - 100, y = self.spinnerPos.y - 100, w = 200, h = 200}
        if(Utils.isInside(position, spinnerBox)) then
            if(0 == table.getn(self.pillBox.pills)) then
                self.spinnerFrame:pause(1)
                return
            end

            if(lume.first(self.pillBox.pills).number == self.spinnerFrame:getSelected()) then
                self.pillBox:removePill()
            else
                self.spinnerFrame:pause(1)
            end
        end
    end
end

return SpinnerSystem
