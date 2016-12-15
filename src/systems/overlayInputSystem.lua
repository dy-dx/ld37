local Utils = require('utils')
overlayInputSystem = tiny.processingSystem(Class{})

function overlayInputSystem:init()
  self.filter = tiny.requireAll('isOverlay')
  self.input = Input()
  self.input:bind('mouse1', 'left_click')
  self.input:bind('escape', 'escape')
end

function overlayInputSystem:preProcess(dt)

end

function overlayInputSystem:postProcess(dt)
end

function overlayInputSystem:overlayActive(e, dt)
    if self.input:pressed('escape') then
        Global.currentGame = nil
    end

  if self.input:pressed('left_click') then
    clickX, clickY = love.mouse.getPosition()
    local position = {x = clickX, y = clickY}

    if love.timer.getTime() - Global.timeSinceOverlayOpened < 0.05 then
        -- we just opened the overlay so don't close it
        return
    end

    local closeHit = lume.any(e.closeHitboxes, function(cHitbox)
        return Utils.isInside(position, cHitbox)
    end)

    if(closeHit) then
        Global.currentGame = nil
        return
    end

    if(not Utils.isInside(position, e.hitbox)) then
        Global.currentGame = nil
        return
    end
  end
end

function overlayInputSystem:overlayNotActive(e, dt)

end

function overlayInputSystem:process(e, dt)
    if(Global.currentGame) then self:overlayActive(e, dt) else self:overlayNotActive(e, dt) end
end

return overlayInputSystem
