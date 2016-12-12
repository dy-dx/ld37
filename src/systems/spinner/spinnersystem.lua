local SpinnerFrame = require 'entities/spinner/spinnerframe'
local Pillbox = require 'entities/spinner/pillbox'
local Pill = require 'entities/spinner/pill'
local Background = require 'entities/spinner/background'
local Utils = require 'utils'

SpinnerSystem = tiny.processingSystem(Class{})

function SpinnerSystem:init()
    self.filter = tiny.requireAll('process', 'isDead', 'spinner', 'isSpinnerFrame')

    self.name = "spinner"
    self.input = Input()
    self.input:bind('mouse1', 'mouse1')
    self.spinnerPos = { x = 480, y = 270 }
    self.pillBoxPos = { x = 90, y = 240, w = 280, h = 60 }
    self.maxPills = 5
    self.pillPadding = 5
    self.background = Background()
    self.backgroundInit = false

    self.totalCooldown = 5
    self.cooldown = 0.1

    Signal.register('startLevel', function(level)
        self:reset()
    end)
end

function SpinnerSystem:reset()
    if self.spinnerFrame then
        world:remove(self.spinnerFrame)
        lume.map(self.pillBox.pills, function(pill)
            world:removeEntity(pill)
        end)
        world:remove(self.pillBox)
        self.spinnerFrame = nil;
        self.pillBox = nil;
    end
    self.cooldown = 0.1
end


function SpinnerSystem:preProcess(dt)
    if not lume.any(Global.currentLevelDefinition.activeGames, function(x)
        return x == 'spinner'
    end) then return end

    if(not backgroundInit) then
        world:addEntity(self.background)
        backgroundInit = true
    end


    if not self.spinnerFrame then
        self.spinnerFrame = SpinnerFrame(self.spinnerPos)
        self.pillBox = Pillbox(self.pillBoxPos, self.maxPills, self.pillPadding)

        world:addEntity(self.spinnerFrame)
        world:addEntity(self.pillBox)
    end

    self.cooldown = self.cooldown - dt

    if self.cooldown <= 0 then
        self.cooldown = self.totalCooldown

        if(self.pillBox:isFull()) then
            Signal.emit('gameover', self.name)
            return;
        end

        local pillNumber = math.random(table.getn(self.spinnerFrame.colors))
        local pillColor = self.spinnerFrame.colors[pillNumber]
        world:addEntity(self.pillBox:addPill(pillNumber, pillColor))
    end
end

function SpinnerSystem:postProcess(dt)
end

function SpinnerSystem:dangerTick()
    if(not self.pillBox) then return end
    if(table.getn(self.pillBox.pills) >= self.pillBox.maxPills - 1) then return Signal.emit('dangerLevel', self.name, 3) end
    if(table.getn(self.pillBox.pills) >= self.pillBox.maxPills - 3) then return Signal.emit('dangerLevel', self.name, 2) end
    return Signal.emit('dangerLevel', self.name, 1)
end

function SpinnerSystem:process(e, dt)
    e:process(dt)
    if e.isDead then
        world:remove(e)
    end

    self:dangerTick()

    if self.input:pressed("mouse1") then
        clickX, clickY = love.mouse.getPosition()
        local position = {x = clickX, y = clickY}
        local spinnerBox = {x = self.spinnerPos.x - 100, y = self.spinnerPos.y - 100, w = 200, h = 200}
        if(Utils.isInside(position, spinnerBox)) then
            if(0 == table.getn(self.pillBox.pills)) then
                self.spinnerFrame:pause(1)
                return
            end

            if(lume.first(self.pillBox.pills).number == self.spinnerFrame:getSelected()) then
                world:remove(self.pillBox:removePill())
            else
                self.spinnerFrame:pause(1)
            end
        end
    end
end

return SpinnerSystem
