LevelProgressionSystem = tiny.processingSystem(Class{})

function LevelProgressionSystem:init()
    self.isCutsceneSystem = true
    self.filter = tiny.requireAll('isLevelProgression')
    self.input = Input()
    self.input:bind('l', 'skiplevel')
end

function LevelProgressionSystem:preProcess(dt)
end

function LevelProgressionSystem:postProcess(dt)
end

function LevelProgressionSystem:process(e, dt)
    -- welcome to hack land
    -- mind your step

    -- cheat code skip level
    if self.input:released('skiplevel') then
        Global.isGameOver = false
        Global.currentGame = nil
        if Global.isCutscene then
            Global.isCutscene = false
            Signal.emit('startLevel', Global.currentLevel)
        else
            -- print('increased currentlevel in LevelProgressionSystem')
            Global.currentLevel = Global.currentLevel + 1
            -- fixme
            Global.currentLevelDefinition = Global.levelDefinitions[Global.currentLevel]
            Signal.emit('startCutscene', Global.currentLevel)
        end
    end

    local finalLevel = table.getn(Global.levelDefinitions)

    Global.currentLevel = lume.clamp(Global.currentLevel, 1, finalLevel)

    Global.currentLevelDefinition = Global.levelDefinitions[Global.currentLevel]

    if Global.currentLevel == finalLevel and not Global.isGameWon then
        Global.isGameWon = true
        Signal.emit('write', "you won", 150000)
    end
end

return LevelProgressionSystem
