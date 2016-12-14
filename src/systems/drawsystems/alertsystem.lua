local AlertSystem = tiny.processingSystem(Class{})

local mask_effect = love.graphics.newShader[[
  uniform float time;
  uniform float addRandomNoise = 0.0;

  highp float rand(vec2 co)
{
    return fract(sin(mod(dot(co.xy, vec2(12.9898, 78.233)), 3.14)) * 43758.5453) - 0.5;
}

  vec4 effect (vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
  if (Texel(texture, texture_coords).rgb == vec3(0.0)) {
  // a discarded pixel wont be applied as the stencil.
  discard;
  } else if (addRandomNoise * rand(vec2(texture_coords.x + time, texture_coords.y + time)) > 0.44) {
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
    love.graphics.setColor(255, 255, 255, 255)
end

function AlertSystem:overlayActive(e, dt)
  -- e:draw()
end

function AlertSystem:overlayNotActive(e, dt)

end

function AlertSystem:process(e, dt)
    e.time = (e.time + dt * 0.001) % 10
    alertChallenge(e, dt, e.alertMask, e.dangerLevel)
end

function maskStencil(mask)
  return function ()
    love.graphics.setShader(mask_effect)
    love.graphics.draw(mask, 0, 0)
    love.graphics.setShader()
  end
end

function alertChallenge(e, dt, mask, dangerLevel)
  if dangerLevel == 1 then
    return
  end

  if dangerLevel == 1 then
    love.graphics.setColor(105, 183, 52, 255)
    mask_effect:send('addRandomNoise', 0.0)
  elseif dangerLevel == 2 then
    love.graphics.setColor(251, 198, 32, 255)
    mask_effect:send('addRandomNoise', 0.0)
  elseif dangerLevel == 3 then
    mask_effect:send('time', e.time)
    mask_effect:send('addRandomNoise', 1.0)
    love.graphics.setColor(184, 31, 40, 255)
  end
  love.graphics.stencil(maskStencil(mask), "replace", 1)
  love.graphics.setStencilTest("greater", 0)

  love.graphics.rectangle("fill", 0, 0, 800, 600)
  love.graphics.setStencilTest()
end

return AlertSystem
