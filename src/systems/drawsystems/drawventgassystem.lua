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
        -- drawing background
        love.graphics.setColor(e.r, e.g, e.b)
        love.graphics.rectangle('fill', e.x, e.y, e.width, e.height)
        -- drawing gas pressure box
        love.graphics.setColor(e.gasPressureBox.r, e.gasPressureBox.g, e.gasPressureBox.b)
        love.graphics.rectangle('fill', e.gasPressureBox.x, e.gasPressureBox.y
            , e.gasPressureBox.width, e.gasPressureBox.height)
        -- drawing gas pressure button
        love.graphics.setColor(e.gasPressureButton.r, e.gasPressureButton.g, e.gasPressureButton.b)
        love.graphics.circle('fill', e.gasPressureButton.x, e.gasPressureButton.y, e.gasPressureButton.radius)
        -- text on button
        local gasPressureFont = love.graphics.newFont(11)
        local gasPressureText = love.graphics.newText(gasPressureFont, e.gasPressureButton.text)
        love.graphics.setColor(0,0,0,255)
        love.graphics.draw(gasPressureText, e.gasPressureButton.x - e.gasPressureButton.radius, e.gasPressureButton.y - 5)
        -- drawing meter
        love.graphics.setColor(255, 0, 0)
        local pressurePercentage = e.currentGasPressure / e.maxGasPressure
        local meterHeight = e.gasPressureBox.height * pressurePercentage
        love.graphics.rectangle('fill', e.gasPressureBox.x
            , e.gasPressureBox.y + e.gasPressureBox.height - meterHeight
            , e.gasPressureBox.width, meterHeight)
        -- drawing oxygen pressure box
        love.graphics.setColor(e.oxygenPressureBox.r, e.oxygenPressureBox.g, e.oxygenPressureBox.b)
        love.graphics.rectangle('fill', e.oxygenPressureBox.x, e.oxygenPressureBox.y
            , e.oxygenPressureBox.width, e.oxygenPressureBox.height)
        -- drawing gas pressure button
        love.graphics.setColor(e.oxygenPressureButton.r, e.oxygenPressureButton.g, e.oxygenPressureButton.b)
        love.graphics.circle('fill', e.oxygenPressureButton.x, e.oxygenPressureButton.y, e.oxygenPressureButton.radius)
        -- text on button
        local oxygenPressureFont = love.graphics.newFont(11)
        local oxygenPressureText = love.graphics.newText(oxygenPressureFont, e.oxygenPressureButton.text)
        love.graphics.setColor(0,0,0,255)
        love.graphics.draw(oxygenPressureText, e.oxygenPressureButton.x - e.oxygenPressureButton.radius, e.oxygenPressureButton.y - 5)

        -- drawing unknown pressure box
        love.graphics.setColor(e.unknownPressureBox.r, e.unknownPressureBox.g, e.unknownPressureBox.b)
        love.graphics.rectangle('fill', e.unknownPressureBox.x, e.unknownPressureBox.y
            , e.unknownPressureBox.width, e.unknownPressureBox.height)
        -- drawing unknown pressure button
        love.graphics.setColor(e.unknownPressureButton.r, e.unknownPressureButton.g, e.unknownPressureButton.b)
        love.graphics.circle('fill', e.unknownPressureButton.x, e.unknownPressureButton.y, e.unknownPressureButton.radius)
        -- text on button
        local unknownPressureFont = love.graphics.newFont(11)
        local unknownPressureText = love.graphics.newText(unknownPressureFont, e.unknownPressureButton.text)
        love.graphics.setColor(0,0,0,255)
        love.graphics.draw(unknownPressureText, e.unknownPressureButton.x - e.unknownPressureButton.radius, e.unknownPressureButton.y - 5)
        -- drawing meter
        love.graphics.setColor(255, 0, 0)
        local pressurePercentage = e.currentUnknownPressure / e.maxUnknownPressure
        local meterHeight = e.unknownPressureBox.height * pressurePercentage
        love.graphics.rectangle('fill', e.unknownPressureBox.x
            , e.unknownPressureBox.y + e.unknownPressureBox.height - meterHeight
            , e.unknownPressureBox.width, meterHeight)
    end
end

return DrawVentGasSystem
