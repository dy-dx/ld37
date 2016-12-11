-- local gamestate = require "lib.gamestate"
local anim8 = require 'vendor/anim8'
local CrewMemberEngineer = Class{}

function CrewMemberEngineer:init()
    self.bobbingSheet = love.graphics.newImage('assets/images/characters/alien_bobbing_sheet.png')
    self.pressButtonSheet = love.graphics.newImage('assets/images/characters/alien_pressButton_sheet.png')
    self.global = true
    self.pos = {x = 100, y = 360}
    self.sprite = self.bobbingSheet

    local bobbingGrid = anim8.newGrid(96, 144, self.bobbingSheet:getWidth(), self.bobbingSheet:getHeight())
    local pressButtonGrid = anim8.newGrid(96, 144, self.pressButtonSheet:getWidth(), self.pressButtonSheet:getHeight())
    self.animationBob = anim8.newAnimation(bobbingGrid('1-2', 1), 0.9)
    self.animationButtonPress = anim8.newAnimation(pressButtonGrid('1-8', 1), .2)
    self.animation = self.animationBob
end

return CrewMemberEngineer
