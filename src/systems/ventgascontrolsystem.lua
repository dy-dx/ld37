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
    e.currentGasPressure = e.currentGasPressure + e.gasGrowthRate * dt
    e.currentUnknownPressure = e.currentUnknownPressure + e.unknownGrowthRate * dt
    if e.currentGasPressure > e.maxGasPressure then
        Signal.emit('gameover')
    end
    if e.currentUnknownPressure > e.maxUnknownPressure then
        Signal.emit('gameover')
    end
    if Global.currentGame == 'ventgas' and self.input:down('left_click') then
        x, y = love.mouse.getPosition()
        if (x - e.gasPressureButton.x)^2 + (y - e.gasPressureButton.y)^2 < e.gasPressureButton.radius^2 then
            e.currentGasPressure = math.max(0, e.currentGasPressure - e.gasPressureDecrease * dt)
        end
        if (x - e.unknownPressureButton.x)^2 + (y - e.unknownPressureButton.y)^2 < e.unknownPressureButton.radius^2 then
            e.currentUnknownPressure = math.max(0, e.currentUnknownPressure - e.unknownPressureDecrease * dt)
        end
        if (x - e.oxygenPressureButton.x)^2 + (y - e.oxygenPressureButton.y)^2 < e.oxygenPressureButton.radius^2 then
            Signal.emit('gameover')
            print("YOU LOSE")
        end
    end
    e.currentGasPressure = math.min(e.currentGasPressure, e.maxGasPressure)
    e.currentUnknownPressure = math.min(e.currentUnknownPressure, e.maxUnknownPressure)
end

return VentGasControlSystem
