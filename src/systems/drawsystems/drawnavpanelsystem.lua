local DrawNavPanelSystem = Class{}
DrawNavPanelSystem = tiny.system(DrawNavPanelSystem)

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
    print('hi')
    love.graphics.rectangle('fill', 0, 300, 800, 200)
end

return DrawNavPanelSystem
