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
    e.currentGasPressure = e.currentGasPressure + e.gasGrowthRate
    if e.currentGasPressure > e.maxGasPressure then
        e.currentGasPressure = e.maxGasPressure + 1
    end
    if self.input:released('left_click') then
        x, y = love.mouse.getPosition()
        if (x - e.gasPressureButton.x)^2 + (y - e.gasPressureButton.y)^2 < e.gasPressureButton.radius^2 then
            e.currentGasPressure = math.max(0, e.currentGasPressure - 100)
        end
    end
end

return VentGasControlSystem
