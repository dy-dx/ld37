OverlaySystem = tiny.processingSystem(Class{})

function OverlaySystem:init()
    self.filter = tiny.requireAll('isOverlay')
    self.isDrawingSystem = true
end

function OverlaySystem:preProcess(dt)
end

function OverlaySystem:postProcess(dt)
end

function OverlaySystem:process(e, dt)
    if(Global.currentGame) then e:draw() end
end

return OverlaySystem
