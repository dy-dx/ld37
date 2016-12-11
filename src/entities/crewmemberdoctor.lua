-- local gamestate = require "lib.gamestate"
local anim8 = require 'vendor/anim8'
local CrewMemberDoctor = Class{}

function CrewMemberDoctor:init()
    self.sprite = love.graphics.newImage('assets/images/characters/doctor_bobbing_sheet.png')
    self.global = true
    self.pos = {x = 550, y = 240}

    local grid = anim8.newGrid(96, 144, self.sprite:getWidth(), self.sprite:getHeight())
    self.animationBob = anim8.newAnimation(grid('1-2', 1), 0.9)
    self.animation = self.animationBob
end

return CrewMemberDoctor
