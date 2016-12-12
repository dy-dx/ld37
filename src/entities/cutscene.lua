local Cutscene = Class{}

function Cutscene:init()
    self.isCutscene = true
    self.dialogueFont = love.graphics.newFont(20)

    self:resetState()
    Signal.register('startCutscene', function(level)
        self:resetState()
    end)
end

function Cutscene:resetState()
    self.shipPos = {x = 200, y = 400}
    self.currentDialogueIndex = 1
end

return Cutscene
