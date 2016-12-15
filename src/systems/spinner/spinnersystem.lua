local SpinnerFrame = require 'entities/spinner/spinnerframe'
local Pillbox = require 'entities/spinner/pillbox'
local Pill = require 'entities/spinner/pill'
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

    -- self.totalCooldown = 5 -- moved to levelDefinitions
    self.cooldown = 0.1
    self.buttonCooldown = 1

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
        Signal.emit("stopwoosh")
        world:remove(self.pillBox)
        self.spinnerFrame = nil
        self.pillBox = nil
    end
    self.cooldown = 0.1
end


function SpinnerSystem:preProcess(dt)
    if not Utils.isAnActiveGame('spinner') then return end

    if not self.spinnerFrame then
        self.spinnerFrame = SpinnerFrame(self.spinnerPos)
        self.pillBox = Pillbox(self.pillBoxPos, self.maxPills, self.pillPadding)

        world:addEntity(self.spinnerFrame)
        world:addEntity(self.pillBox)
    end

    self.cooldown = self.cooldown - dt

    if self.cooldown <= 0 then
        -- self.cooldown = self.totalCooldown
        self.cooldown = Global.currentLevelDefinition.spinner.timeToPill

        if(self.pillBox:isFull()) then
            Signal.emit('gameover', self.name)
            return
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

function SpinnerSystem:pressedButton(e)
    clickX, clickY = love.mouse.getPosition()

    local radius = e.buttonUpSprite:getWidth() / 2
    return (e.buttonCenter.x - clickX) * (e.buttonCenter.x - clickX) +
        (e.buttonCenter.y - clickY) * (e.buttonCenter.y - clickY)
        < radius * radius
end

function SpinnerSystem:startCooldown(e, cooldown)
    e.buttonCooldownTimer = cooldown
    self.spinnerFrame:pause(cooldown)
end

function SpinnerSystem:clickScreen(e)
    if self.input:pressed("mouse1") then
        if(SpinnerSystem:pressedButton(e)) then
            if(0 == table.getn(self.pillBox.pills)) then
                Signal.emit("failBlip")
                self:startCooldown(e, self.buttonCooldown)
                return
            end

            if(lume.first(self.pillBox.pills).number == self.spinnerFrame:getSelected()) then
                self:startCooldown(e, .1)
                local deadPill = self.pillBox:removePill()
                deadPill.isSuicidal = true
                Signal.emit("woosh")
            else
                Signal.emit("failBlip")
                self:startCooldown(e, self.buttonCooldown)
                return
            end
        end
    end
end

function SpinnerSystem:process(e, dt)
    if not Utils.isAnActiveGame('spinner') then return end
    e:process(dt)
    if e.isDead then world:remove(e) end

    e.buttonCooldownTimer = e.buttonCooldownTimer - dt
    if(e.buttonCooldownTimer < 0) then
        e.buttonCooldownTimer = 0
    end

    self:dangerTick()
    self:clickScreen(e)

end

return SpinnerSystem
