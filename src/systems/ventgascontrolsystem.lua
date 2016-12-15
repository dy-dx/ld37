local Utils = require 'utils'
local VentGasControlSystem = tiny.processingSystem(Class{})

function VentGasControlSystem:init()
    self.filter = tiny.requireAll('isVentGasControlSystem')
    self.input = Input()
    self.input:bind('mouse1', 'left_click')
end

function VentGasControlSystem:preProcess(dt)
end

function VentGasControlSystem:postProcess(dt)
end

function insideButton(button, x, y)
    if (x - button.x)^2 + (y - button.y)^2 < button.radius^2 then
        return button.buttonType
    end

    return nil
end

local function checkButton(button, meter, x, y, dt)
    if (x - button.x)^2 + (y - button.y)^2 < button.radius^2 then
        button.buttonDown = true
        if button.buttonType == 'oxygen' then
            Signal.emit('gameover', 'ventgas')
        else
            meter.currentPressure = math.max(0, meter.currentPressure - meter.pressureDecrease * dt)
        end
    end
end

local function toggleButtonOff(button)
    if button.buttonDown then
        button.buttonDown = false
    end
end

local function maintainVent(meter, dt)
    meter.currentPressure = meter.currentPressure + meter.growthRate * dt
    if meter.currentPressure > meter.maxPressure then
        Signal.emit('gameover', 'ventgas')
    end
end

local function setDangerLevel(e)
    local totalGasTime = e.gasMeter.maxPressure/e.gasMeter.growthRate
    local currentGasTimeLeft = totalGasTime - e.gasMeter.currentPressure/e.gasMeter.growthRate
    local totalWasteTime = e.wasteMeter.maxPressure/e.wasteMeter.growthRate
    local currentWasteTimeLeft = totalWasteTime - e.wasteMeter.currentPressure/e.wasteMeter.growthRate
    if currentGasTimeLeft < e.timeLeftToTriggerDangerLevelThree or currentWasteTimeLeft < e.timeLeftToTriggerDangerLevelThree then
        e.dangerLevel = 3
    elseif currentGasTimeLeft < e.timeLeftToTriggerDangerLevelTwo or currentWasteTimeLeft < e.timeLeftToTriggerDangerLevelTwo then
        e.dangerLevel = 2
    else
        e.dangerLevel = 1
    end
end
function VentGasControlSystem:process(e, dt)
    -- don't run the game if 'ventgas' is not in the list of currently active games
    if not Utils.isAnActiveGame('ventgas') then return end

    maintainVent(e.gasMeter, dt)
    maintainVent(e.wasteMeter, dt)

    if Global.currentGame == 'ventgas' and self.input:pressed('left_click') then
        local x, y = love.mouse.getPosition()
        local buttonType = insideButton(e.gasPressureButton, x, y) or insideButton(e.wastePressureButton, x, y)

        if(buttonType == "gas") then
            Signal.emit("spray")
        end

        if(buttonType == "waste") then
            Signal.emit("sludge")
        end
    end

    if Global.currentGame == 'ventgas' then
        if self.input:down('left_click') then
            local x, y = love.mouse.getPosition()
            checkButton(e.gasPressureButton, e.gasMeter, x, y, dt)
            checkButton(e.wastePressureButton, e.wasteMeter, x, y, dt)
            checkButton(e.oxygenPressureButton, e.oxygenMeter, x, y, dt)
        else
            toggleButtonOff(e.gasPressureButton)
            toggleButtonOff(e.oxygenPressureButton)
            toggleButtonOff(e.wastePressureButton)

            Signal.emit("stopspray")
            Signal.emit("stopsludge")
        end
    end
    e.gasMeter.currentPressure = math.min(e.gasMeter.currentPressure, e.gasMeter.maxPressure)
    e.wasteMeter.currentPressure = math.min(e.wasteMeter.currentPressure, e.wasteMeter.maxPressure)
    setDangerLevel(e)
    Signal.emit('dangerLevel', 'ventgas', e.dangerLevel)

end

return VentGasControlSystem
