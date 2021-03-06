PanelSystem = tiny.processingSystem(Class{})

function PanelSystem:init()
    self.filter = tiny.requireAll('isPanel')
    self.isDrawingSystem = true
end

function PanelSystem:preProcess(dt)
end

function PanelSystem:postProcess(dt)
end

function PanelSystem:process(e, dt)
    e:draw(dt)
end

return PanelSystem
