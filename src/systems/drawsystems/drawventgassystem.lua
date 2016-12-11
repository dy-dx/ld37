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
    if Global.currentGame == 'ventgas' then
        -- drawing background
        love.graphics.setColor(e.r, e.g, e.b)
        love.graphics.rectangle('fill', e.x, e.y, e.width, e.height)

        -- drawing gas pressure box
        DrawVentGasSystem:drawBox(e.gasPressureBox)
        -- drawing gas pressure button
        DrawVentGasSystem:drawButton(e.gasPressureButton)
        -- drawing gas meter
        DrawVentGasSystem:drawMeter(e.gasPressureBox, e.gasMeter)

        -- drawing oxygen pressure box
        DrawVentGasSystem:drawBox(e.oxygenPressureBox)
        -- drawing gas pressure button
        DrawVentGasSystem:drawButton(e.oxygenPressureButton)

        -- drawing unknown pressure box
        DrawVentGasSystem:drawBox(e.unknownPressureBox)
        -- drawing unknown pressure button
        DrawVentGasSystem:drawButton(e.unknownPressureButton)
        -- drawing unknown meter
        DrawVentGasSystem:drawMeter(e.unknownPressureBox, e.unknownMeter)
    end
end

function DrawVentGasSystem:drawBox(box)
    love.graphics.setColor(box.r, box.g, box.b)
    love.graphics.rectangle('fill', box.x, box.y
        , box.width, box.height)
end

function DrawVentGasSystem:drawButton(button)
    love.graphics.setColor(button.r, button.g, button.b)
    love.graphics.circle('fill', button.x, button.y, button.radius)
    -- text on button
    local gasFont = love.graphics.newFont(11)
    local gasText = love.graphics.newText(gasFont, button.text)
    love.graphics.setColor(0,0,0,255)
    love.graphics.draw(gasText, button.x - button.radius, button.y - 5)
end

function DrawVentGasSystem:drawMeter(box, meter)
    love.graphics.setColor(255, 0, 0)
    local pressurePercentage = meter.currentPressure / meter.maxPressure
    local meterHeight = box.height * pressurePercentage
    love.graphics.rectangle('fill', box.x
        , box.y + box.height - meterHeight
        , box.width, meterHeight)

end

return DrawVentGasSystem
