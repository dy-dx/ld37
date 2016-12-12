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

    -- cheat code skip level
    if self.input:released('skiplevel') then
        Global.currentLevel = Global.currentLevel + 1
    end

    local lastLevel = table.getn(Global.levelDefinitions)

    Global.currentLevel = lume.clamp(Global.currentLevel, 1, lastLevel)

    Global.currentLevelDefinition = Global.levelDefinitions[Global.currentLevel]

    if Global.currentLevel == lastLevel and not Global.isGameWon then
        Global.isGameWon = true
        Signal.emit('write', "you won", 150000)
    end
end

return LevelProgressionSystem
