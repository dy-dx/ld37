OverlaySystem = tiny.processingSystem(Class{})

function OverlaySystem:init()
    self.filter = tiny.requireAll('isOverlay')
    self.isDrawingSystem = true
end

function OverlaySystem:preProcess(dt)

end

function OverlaySystem:postProcess(dt)
end

function OverlaySystem:overlayActive(e, dt)
    e:draw()
end

function OverlaySystem:overlayNotActive(e, dt)

end

function OverlaySystem:process(e, dt)
    if(Global.currentGame) then self:overlayActive(e, dt) else self:overlayNotActive(e, dt) end
end

return OverlaySystem
