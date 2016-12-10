local DrawNavPanelSystem = Class{}
DrawNavPanelSystem = tiny.processingSystem(DrawNavPanelSystem)

function DrawNavPanelSystem:init()
    self.isDrawingSystem = true
    self.filter = tiny.requireAll('isNavPanel')
end

function DrawNavPanelSystem:preProcess(dt)
    love.graphics.setColor(255, 255, 255, 255)
end

function DrawNavPanelSystem:postProcess(dt)
    love.graphics.setColor(255, 255, 255, 255)
end

function DrawNavPanelSystem:process(e, dt)
    love.graphics.rectangle('fill', 100, 450, 600, 150)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', 250, 480, 400, 90)
end

return DrawNavPanelSystem
