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

local function drawBox(box)
    love.graphics.setColor(box.r, box.g, box.b)
    love.graphics.rectangle('fill', box.x, box.y
        , box.width, box.height)
end

local function drawButton(button)
    love.graphics.setColor(button.r, button.g, button.b)
    love.graphics.circle('fill', button.x, button.y, button.radius)
    -- text on button
    local gasFont = love.graphics.newFont(11)
    local gasText = love.graphics.newText(gasFont, button.text)
    love.graphics.setColor(0,0,0,255)
    love.graphics.draw(gasText, button.x - button.radius, button.y - 5)
end

local function drawMeter(box, meter)
    love.graphics.setColor(255, 0, 0)
    local pressurePercentage = meter.currentPressure / meter.maxPressure
    local meterHeight = box.height * pressurePercentage
    love.graphics.rectangle('fill', box.x
        , box.y + box.height - meterHeight
        , box.width, meterHeight)

end
function DrawVentGasSystem:process(e, dt)
    if Global.currentGame == 'ventgas' then
        -- drawing background
        love.graphics.setColor(e.r, e.g, e.b)
        love.graphics.rectangle('fill', e.x, e.y, e.width, e.height)

        -- drawing gas pressure box
        drawBox(e.gasPressureBox)
        -- drawing gas pressure button
        drawButton(e.gasPressureButton)
        -- drawing gas meter
        drawMeter(e.gasPressureBox, e.gasMeter)

        -- drawing oxygen pressure box
        drawBox(e.oxygenPressureBox)
        -- drawing gas pressure button
        drawButton(e.oxygenPressureButton)

        -- drawing unknown pressure box
        drawBox(e.unknownPressureBox)
        -- drawing unknown pressure button
        drawButton(e.unknownPressureButton)
        -- drawing unknown meter
        drawMeter(e.unknownPressureBox, e.unknownMeter)
    end
end

return DrawVentGasSystem
