LevelProgressionSystem = tiny.processingSystem(Class{})

function LevelProgressionSystem:init()
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

    -- for now, just restart the current level when isGameOver
    if Global.isGameOver then
        Global.isGameOver = false
        Signal.emit('startLevel', Global.currentLevel)
    end

    -- cheat code skip level
    if self.input:released('skiplevel') then
        Global.currentLevel = Global.currentLevel + 1
        Signal.emit('startLevel', Global.currentLevel)
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
