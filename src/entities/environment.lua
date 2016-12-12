-- local gamestate = require "lib.gamestate"

local Environment = Class{}

local tr_mask = love.graphics.newImage("assets/images/stencils/background_tr.png")
local tl_mask = love.graphics.newImage("assets/images/stencils/background_tl.png")
local br_mask = love.graphics.newImage("assets/images/stencils/background_br.png")
local bl_mask = love.graphics.newImage("assets/images/stencils/background_bl.png")

local mask_effect = love.graphics.newShader[[
  vec4 effect (vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
  if (Texel(texture, texture_coords).rgb == vec3(0.0)) {
  // a discarded pixel wont be applied as the stencil.
  discard;
  }
  return vec4(1.0);
  }
  ]]

function maskStencil(mask)
  return function ()
    love.graphics.setShader(mask_effect)
    love.graphics.draw(mask, 0, 0)
    love.graphics.setShader()
  end
end

function alertChallenge(mask)
  love.graphics.stencil(maskStencil(mask), "replace", 1)
  love.graphics.setStencilTest("greater", 0)
  love.graphics.setColor(255, 0, 0, 120)
  love.graphics.rectangle("fill", 0, 0, 800, 600)
  love.graphics.setStencilTest()
  love.graphics.setColor(255, 255, 255, 255)
end

function Environment:init()
    self.global = true
    self.pos = {x = 0, y = 0}

    self.sprite = love.graphics.newImage("assets/images/background.png")
    Signal.emit('theme')
end

function Environment:draw(dt)
    self.isEnvironment = true
    self.controllable = true

    alertChallenge(tr_mask)
    alertChallenge(tl_mask)
    alertChallenge(br_mask)
    alertChallenge(bl_mask)
end

return Environment
