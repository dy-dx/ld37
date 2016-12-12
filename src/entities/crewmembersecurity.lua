-- local gamestate = require "lib.gamestate"
local anim8 = require 'vendor/anim8'
local CrewMemberSecurity = Class{}

function CrewMemberSecurity:init()
    self.assignedConsole = 'misslowcommand'
    self.isCrewMemberAnimationSystem=true
    self.global = true
    self.bobbingSheet = love.graphics.newImage('assets/images/characters/security_bobbing_sheet.png')
    self.pressButtonSheet = love.graphics.newImage('assets/images/characters/security_pressButton_sheet.png')
    self.pos = {x = 610, y = 355}
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

return CrewMemberSecurity
