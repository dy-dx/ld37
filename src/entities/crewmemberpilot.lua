-- local gamestate = require "lib.gamestate"
local anim8 = require 'vendor/anim8'
local CrewMemberPilot = Class{}

function CrewMemberPilot:init()
    self.bobbingSheet = love.graphics.newImage('assets/images/characters/pilot_bobbing_sheet.png')
    self.pressButtonSheet = love.graphics.newImage('assets/images/characters/pilot_pressButton_sheet.png')
    self.global = true
    self.pos = {x = 140, y = 240}
    self.sprite = self.pressButtonSheet

    local bobbingGrid = anim8.newGrid(96, 144, self.bobbingSheet:getWidth(), self.bobbingSheet:getHeight())
    local pressButtonGrid = anim8.newGrid(96, 144, self.pressButtonSheet:getWidth(), self.pressButtonSheet:getHeight())
    self.animationBob = anim8.newAnimation(bobbingGrid('1-2', 1), 0.9)
    self.animationButtonPress = anim8.newAnimation(pressButtonGrid('1-4', 1), .2)
    self.animation = self.animationButtonPress
end

return CrewMemberPilot
