local DrawVentGasSystem = Class{}

DrawVentGasSystem = tiny.processingSystem(DrawVentGasSystem)

function DrawVentGasSystem:init()
    self.isDrawingSystem = true
    self.filter = tiny.requireAll("isDrawVentGasSystem")
end

function DrawVentGasSystem:preProcess(dt)

end

function DrawVentGasSystem:postProcess(dt)
    love.graphics.setColor(255, 255, 255)
end

function DrawVentGasSystem:process(e, dt)
    if e.isVisible then
        love.graphics.setColor(e.r, e.g, e.b)
        love.graphics.rectangle('fill', e.x, e.y, e.width, e.height)

        love.graphics.setColor(e.gasPressureBox.r, e.gasPressureBox.g, e.gasPressureBox.b)
        love.graphics.rectangle('fill', e.gasPressureBox.x, e.gasPressureBox.y
            , e.gasPressureBox.width, e.gasPressureBox.height)

        love.graphics.setColor(e.gasPressureButton.r, e.gasPressureButton.g, e.gasPressureButton.b)
        love.graphics.circle('fill', e.gasPressureButton.x, e.gasPressureButton.y, e.gasPressureButton.radius)

        local gasPressureFont = love.graphics.newFont(11)
        local gasPressureText = love.graphics.newText(gasPressureFont, e.gasPressureButton.text)
        love.graphics.setColor(0,0,0,255)
        love.graphics.draw(gasPressureText, e.gasPressureButton.x - e.gasPressureButton.radius, e.gasPressureButton.y - 5)

        love.graphics.setColor(255, 0, 0)
        local pressurePercentage = e.currentGasPressure / e.maxGasPressure
        local meterHeight = e.gasPressureBox.height * pressurePercentage
        love.graphics.rectangle('fill', e.gasPressureBox.x
            , e.gasPressureBox.y + e.gasPressureBox.height - meterHeight
            , e.gasPressureBox.width, meterHeight)
    end
end

return DrawVentGasSystem
