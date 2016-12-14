local anim8 = require 'vendor/anim8'
local Cutscene = Class{}

function Cutscene:init()
    self.isCutscene = true
    self.dialogueFont = love.graphics.newFont(20)
    self.sprite = nil
    self.animation = nil
    self.shipSheet = love.graphics.newImage('assets/images/ship_sheet.png')
    self.explosionSheet = love.graphics.newImage('assets/images/explosion_sheet.png')
    local g1 = anim8.newGrid(50, 45, self.shipSheet:getWidth(), self.shipSheet:getHeight())
    self.shipAnimation = anim8.newAnimation(g1('1-2', 1), 0.1)
    local g2 = anim8.newGrid(100, 100, self.explosionSheet:getWidth(), self.explosionSheet:getHeight())
    self.explosionAnimation = anim8.newAnimation(g2('1-9', 1, '1-9', 2, '1-9', 3, '1-9', 4, '1-9', 5, '1-9', 6, '1-9', 7, '1-9', 8, '1-9', 9), 0.03, 'pauseAtEnd')

    self.timer = Timer.new()

    self.maxTextWidth = 500
    self.textSpeed = 20000
    self:resetState()
    Signal.register('startCutscene', function(cutsceneType)
        Global.isCutscene = true
        print('resetState', cutsceneType)
        self:resetState(cutsceneType)
    end)
end

function Cutscene:resetLine()
    self.textTime = 0
    self.currentCharacter = 1
    self.drawRestOfText = false
end

function Cutscene:resetState(cutsceneType)
    self:resetLine()
    self.timer:clear()
    self.sprite = self.shipSheet
    self.animation = self.shipAnimation
    self.pos = {x = 330, y = 340}
    self.alpha = 1
    self.rot = 0
    self.offset = {x = 0, y = 0}
    self.gameOverText = ''
    self.cutsceneType = 'intro'
    self.currentDialogueIndex = 1

    -- explosion sequence
    if cutsceneType == 'gameover' then
        self.cutsceneType = 'gameover'
        self.timer:script(function(wait)
            self.timer:tween(
                2, -- seconds
                self.pos,
                { x = self.pos.x + 20 },
                'linear'
            )
            wait(2)

            self.offset = {x = 25, y = 30}
            self.sprite = self.explosionSheet
            self.animation = self.explosionAnimation
            self.animation:gotoFrame(1)
            self.animation:resume()
            wait(1)
            self.gameOverText = 'Game Over'
        end)
    end
end

return Cutscene
