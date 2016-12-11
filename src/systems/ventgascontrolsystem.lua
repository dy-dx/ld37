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

function VentGasControlSystem:process(e, dt)
    e.gasMeter.currentPressure = e.gasMeter.currentPressure + e.gasMeter.growthRate * dt
    e.unknownMeter.currentPressure = e.unknownMeter.currentPressure + e.unknownMeter.growthRate * dt
    if e.gasMeter.currentPressure > e.gasMeter.maxPressure then
        Signal.emit('gameover')
    end
    if e.unknownMeter.currentPressure > e.unknownMeter.maxPressure then
        Signal.emit('gameover')
    end
    if Global.currentGame == 'ventgas' and self.input:down('left_click') then
        x, y = love.mouse.getPosition()
        if (x - e.gasPressureButton.x)^2 + (y - e.gasPressureButton.y)^2 < e.gasPressureButton.radius^2 then
            e.gasMeter.currentPressure = math.max(0, e.gasMeter.currentPressure - e.gasMeter.pressureDecrease * dt)
        end
        if (x - e.unknownPressureButton.x)^2 + (y - e.unknownPressureButton.y)^2 < e.unknownPressureButton.radius^2 then
            e.unknownMeter.currentPressure = math.max(0, e.unknownMeter.currentPressure - e.unknownMeter.pressureDecrease * dt)
        end
        if (x - e.oxygenPressureButton.x)^2 + (y - e.oxygenPressureButton.y)^2 < e.oxygenPressureButton.radius^2 then
            Signal.emit('gameover')
            print("YOU LOSE")
        end
    end
    e.gasMeter.currentPressure = math.min(e.gasMeter.currentPressure, e.gasMeter.maxPressure)
    e.unknownMeter.currentPressure = math.min(e.unknownMeter.currentPressure, e.unknownMeter.maxPressure)
end

return VentGasControlSystem
