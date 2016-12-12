-- local gamestate = require "lib.gamestate"
local anim8 = require 'vendor/anim8'
local CrewMemberPilot = Class{}

function CrewMemberPilot:init()
    self.assignedConsole = 'ventgas'
    self.isCrewMemberAnimationSystem=true
    self.global = true
    self.bobbingSheet = love.graphics.newImage('assets/images/characters/pilot_bobbing_sheet.png')
    self.pressButtonSheet = love.graphics.newImage('assets/images/characters/pilot_pressButton_sheet.png')
    self.pos = {x = 140, y = 240}
    self.bobRate = 0.9
    self.buttonPressAnimationRate = .2
    self.nframes = 4
    self.timerButtonPressDuration = nil
    self.timerButtonPressProbCheck = nil

    local bobbingGrid = anim8.newGrid(96, 144, self.bobbingSheet:getWidth(), self.bobbingSheet:getHeight())
    local pressButtonGrid = anim8.newGrid(96, 144, self.pressButtonSheet:getWidth(), self.pressButtonSheet:getHeight())
    self.animationBob = anim8.newAnimation(bobbingGrid('1-2', 1), self.bobRate)
    self.animationButtonPress = anim8.newAnimation(pressButtonGrid('1-' .. self.nframes, 1)
        , self.buttonPressAnimationRate)

    self.animation = self.animationBob
    self.sprite = self.bobbingSheet
    self.isBobbing = true
end

return CrewMemberPilot
