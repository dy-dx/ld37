-- local gamestate = require "lib.gamestate"
local anim8 = require 'vendor/anim8'
local CrewMemberPilot = Class{}

function CrewMemberPilot:init()
    self.sprite = love.graphics.newImage('assets/images/characters/pilot_bobbing_sheet.png')
    self.global = true
    self.pos = {x = 500, y = 500}

    local grid = anim8.newGrid(96, 144, self.sprite:getWidth(), self.sprite:getHeight())
    self.animationBob = anim8.newAnimation(grid('1-2', 1), 0.9)
    self.animation = self.animationBob
end

return CrewMemberPilot
