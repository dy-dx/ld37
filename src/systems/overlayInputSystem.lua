local Utils = require('utils')
overlayInputSystem = tiny.processingSystem(Class{})

function overlayInputSystem:init()
  self.filter = tiny.requireAll('isOverlay')
  self.input = Input()
  self.input:bind('mouse1', 'left_click')
end

function overlayInputSystem:preProcess(dt)

end

function overlayInputSystem:postProcess(dt)
end

function overlayInputSystem:overlayActive(e, dt)
  if self.input:released('left_click') then
    print("click happened")
    clickX, clickY = love.mouse.getPosition()

    local closeHit = lume.any(e.closeHitboxes, function(cHitbox)
      return Utils.isInside({x = clickX, y = clickY}, cHitbox)
    end)

    if(closeHit) then
      Global.currentGame = nil
    end
  end
end

function overlayInputSystem:overlayNotActive(e, dt)

end

function overlayInputSystem:process(e, dt)
    if(Global.currentGame) then self:overlayActive(e, dt) else self:overlayNotActive(e, dt) end
end

return overlayInputSystem
