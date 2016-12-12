VentGasControlSystem = tiny.processingSystem(Class{})

function VentGasControlSystem:init()
    self.filter = tiny.requireAll('isVentGasControlSystem')
    self.input = Input()
    self.input:bind('mouse1', 'left_click')
end

function VentGasControlSystem:preProcess(dt)
end

function VentGasControlSystem:postProcess(dt)
end

local function checkButton(button, meter, x, y, dt)
    if (x - button.x)^2 + (y - button.y)^2 < button.radius^2 then
        button.buttonDown = true
        if button.buttonType == 'oxygen' then
            Signal.emit('gameover')
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
        Signal.emit('gameover')
    end
end

function VentGasControlSystem:process(e, dt)
    -- don't run the game if 'ventgas' is not in the list of currently active games
    if not lume.any(Global.currentLevelDefinition.activeGames, function(x) return x == 'ventgas' end) then
        return
    end

    maintainVent(e.gasMeter, dt)
    maintainVent(e.wasteMeter, dt)
    if Global.currentGame == 'ventgas' and self.input:down('left_click') then
        local x, y = love.mouse.getPosition()
        checkButton(e.gasPressureButton, e.gasMeter, x, y, dt)
        checkButton(e.wastePressureButton, e.wasteMeter, x, y, dt)
        checkButton(e.oxygenPressureButton, e.oxygenMeter, x, y, dt)
    end
    if Global.currentGame == 'ventgas' and self.input:released('left_click') then
        toggleButtonOff(e.gasPressureButton)
        toggleButtonOff(e.oxygenPressureButton)
        toggleButtonOff(e.wastePressureButton)
    end
    e.gasMeter.currentPressure = math.min(e.gasMeter.currentPressure, e.gasMeter.maxPressure)
    e.wasteMeter.currentPressure = math.min(e.wasteMeter.currentPressure, e.wasteMeter.maxPressure)
end

return VentGasControlSystem
