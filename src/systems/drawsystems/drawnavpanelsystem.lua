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
    -- "lcd" display bg
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', e.lcdpos.x, e.lcdpos.y, e.lcdpos.w, e.lcdpos.h)

    -- calculate ship triangle points
    local progressPct = e.secondsSinceDeparture / e.levelDuration
    local sPos = {
        x = (e.lcdpos.x + progressPct * e.lcdpos.w),
        y = e.lcdpos.y + e.lcdpos.h/2 + e.shipYOffset
    }
    local sx0, sy0 = rotatePoint(sPos.x, sPos.y - 14, e.rotation, sPos.x, sPos.y)
    local sx1, sy1 = rotatePoint(sPos.x, sPos.y + 14, e.rotation, sPos.x, sPos.y)
    local sx2, sy2 = rotatePoint(sPos.x + 30, sPos.y, e.rotation, sPos.x, sPos.y)
    -- for later use in gameplay logic, shhh is ok
    e.shipTipX = sx2
    e.shipTipY = sy2
    -- a hack so we dont draw the tip of the ship outside of the panel
    sy0 = math.max(sy0, e.pos.y)
    sy2 = math.max(sy2, e.pos.y)

    love.graphics.setColor(255, 255, 255, 255)

    drawDottedLine(e.lcdpos.x, e.lcdpos.y + e.lcdpos.h/2, e.lcdpos.x + e.lcdpos.w, e.lcdpos.y + e.lcdpos.h/2)
    love.graphics.circle('fill', e.lcdpos.x + e.lcdpos.w - e.planetRadius, e.lcdpos.y + e.lcdpos.h/2, e.planetRadius)
    -- draw ship
    love.graphics.polygon('fill', sx0, sy0, sx1, sy1, sx2, sy2)

    love.graphics.setColor(255, 255, 255, 255)

    -- panel sprite
    love.graphics.draw(e.panelSprite, e.pos.x, e.pos.y)
    -- buttons
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
    -- debug panel gfx
    -- love.graphics.setColor(255, 255, 255, 255)
    -- love.graphics.rectangle('fill', e.pos.x, e.pos.y, e.pos.w, e.pos.h)
    -- debug button gfx
    -- love.graphics.rectangle('fill', e.leftButton.x, e.leftButton.y, e.leftButton.w, e.leftButton.h)
    -- love.graphics.rectangle('fill', e.rightButton.x, e.rightButton.y, e.rightButton.w, e.rightButton.h)
end

return DrawNavPanelSystem
