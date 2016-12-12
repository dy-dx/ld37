local CutsceneControlSystem = tiny.processingSystem(Class{})

function CutsceneControlSystem:init()
    self.filter = tiny.requireAll('isCutscene')
    self.isCutsceneSystem = true
    self.input = Input()
    self.input:bind('mouse1', 'left_click')

    Signal.register('startCutscene', function(level)
        Global.currentLevelDefinition = Global.levelDefinitions[Global.currentLevel]
        Global.isCutscene = true
    end)
end

function CutsceneControlSystem:preProcess(dt)
end

function CutsceneControlSystem:postProcess(dt)
end

local endCutscene = function()
    if Global.isGameWon then return end

    Global.isCutscene = false
    Signal.emit('startLevel', Global.currentLevel)
end

function CutsceneControlSystem:process(e, dt)
    if not Global.isCutscene then return end

    if self.input:released('left_click') then
        -- go to next dialogue line. if we already displayed the last line, then end cutscene
        if e.currentDialogueIndex >= table.getn(Global.currentLevelDefinition.cutsceneDialogue) then
            print('endcutscene')
            endCutscene()
        else
            print('draw next dialogue')
            e.currentDialogueIndex = e.currentDialogueIndex + 1
        end
    end
end

return CutsceneControlSystem
