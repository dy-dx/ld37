AlertSystem = tiny.processingSystem(Class{})

local mask_effect = love.graphics.newShader[[
  vec4 effect (vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
  if (Texel(texture, texture_coords).rgb == vec3(0.0)) {
  // a discarded pixel wont be applied as the stencil.
  discard;
  }
  return vec4(1.0);
  }
  ]]

function AlertSystem:init()
  self.filter = tiny.requireAll('isScreen')
  self.isDrawingSystem = true
end

function AlertSystem:preProcess(dt)

end

function AlertSystem:postProcess(dt)
end

function AlertSystem:overlayActive(e, dt)
  -- e:draw()
end

function AlertSystem:overlayNotActive(e, dt)

end

function AlertSystem:process(e, dt)
  alertChallenge(e.alertMask, e.dangerLevel)


  -- if(Global.currentGame) then self:overlayActive(e, dt) else self:overlayNotActive(e, dt) end
end

function maskStencil(mask)
  return function ()
    love.graphics.setShader(mask_effect)
    love.graphics.draw(mask, 0, 0)
    love.graphics.setShader()
  end
end

function alertChallenge(mask, dangerLevel)
  if dangerLevel == 1 then
    return
  end

  love.graphics.stencil(maskStencil(mask), "replace", 1)
  love.graphics.setStencilTest("greater", 0)

  if dangerLevel == 2 then
    love.graphics.setColor(164, 131, 91, 255)
  elseif dangerLevel == 3 then
    love.graphics.setColor(164, 91, 131, 255)
  end

  love.graphics.rectangle("fill", 0, 0, 800, 600)
  love.graphics.setStencilTest()
  love.graphics.setColor(255, 255, 255, 255)
end

return AlertSystem
