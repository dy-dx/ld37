LayerSystem = tiny.processingSystem(Class{})

function LayerSystem:init()
    self.isDrawingSystem = true
    self.filter = tiny.requireAll('isDrawLayer')
end

function LayerSystem:preProcess(dt)
end

function LayerSystem:postProcess(dt)
end

function LayerSystem:process(e, dt)
    e:draw(dt)
end

return LayerSystem
