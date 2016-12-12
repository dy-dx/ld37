local DrawNavPanelSystem = Class{}
DrawNavPanelSystem = tiny.processingSystem(DrawNavPanelSystem)

function DrawNavPanelSystem:init()
    self.isDrawingSystem = true
    self.filter = tiny.requireAll('isNavPanel')
end

function DrawNavPanelSystem:preProcess(dt)
end

function DrawNavPanelSystem:postProcess(dt)
    love.graphics.setColor(255, 255, 255, 255)
end

local rotatePoint = function(x, y, theta, x0, y0)
    return ((x-x0) * math.cos(theta) - (y-y0) * math.sin(theta) + x0),
        ((x-x0) * math.sin(theta) + (y-y0) * math.cos(theta) + y0)
end

local function drawDottedLine(x1, y1, x2, y2)
    love.graphics.setPointSize(1)
    local x, y = x2 - x1, y2 - y1
    local len = math.sqrt(x^2 + y^2)
    local stepx, stepy = x / len, y / len
    x = x1
    y = y1
    for i = 1, len, 3 do
        love.graphics.points(x, y)
        x = x + stepx*3
        y = y + stepy*3
    end
end

function DrawNavPanelSystem:process(e, dt)
    -- panel sprite
    love.graphics.draw(e.panelSprite, e.pos.x, e.pos.y)
    -- debug panel gfx
    -- love.graphics.setColor(255, 255, 255, 255)
    -- love.graphics.rectangle('fill', e.pos.x, e.pos.y, e.pos.w, e.pos.h)
    -- love.graphics.setColor(100, 100, 0, 255)
    -- love.graphics.rectangle('fill', e.lcdpos.x, e.lcdpos.y, e.lcdpos.w, e.lcdpos.h)

    -- buttons
    love.graphics.setColor(255, 255, 255, 255)
    local scaleHack = 0.9
    if e.leftButtonDown then
        love.graphics.draw(e.leftButtonDownSprite, e.leftButton.x, e.leftButton.y)
    else
        love.graphics.draw(e.leftButtonSprite, e.leftButton.x, e.leftButton.y)
    end
    if e.rightButtonDown then
        love.graphics.draw(e.rightButtonDownSprite, e.rightButton.x, e.rightButton.y)
    else
        love.graphics.draw(e.rightButtonSprite, e.rightButton.x, e.rightButton.y)
    end
    -- debug button gfx
    -- love.graphics.rectangle('fill', e.leftButton.x, e.leftButton.y, e.leftButton.w, e.leftButton.h)
    -- love.graphics.rectangle('fill', e.rightButton.x, e.rightButton.y, e.rightButton.w, e.rightButton.h)

    -- draw ship
    local progressPct = e.secondsSinceDeparture / e.levelDuration
    local sPos = {
        x = (e.lcdpos.x + progressPct * e.lcdpos.w),
        y = e.lcdpos.y + e.lcdpos.h/2 + e.shipYOffset
    }
    sx0, sy0 = rotatePoint(sPos.x, sPos.y - 15, e.rotation, sPos.x, sPos.y)
    sx1, sy1 = rotatePoint(sPos.x, sPos.y + 15, e.rotation, sPos.x, sPos.y)
    sx2, sy2 = rotatePoint(sPos.x + 30, sPos.y, e.rotation, sPos.x, sPos.y)
    love.graphics.setColor(255, 255, 255)
    drawDottedLine(e.lcdpos.x+3, e.lcdpos.y + e.lcdpos.h/2, e.lcdpos.x+3 + e.lcdpos.w, e.lcdpos.y + e.lcdpos.h/2)
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.polygon('fill', sx0, sy0, sx1, sy1, sx2, sy2)
end

return DrawNavPanelSystem
