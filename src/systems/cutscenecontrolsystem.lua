local CutsceneControlSystem = tiny.processingSystem(Class{})

function CutsceneControlSystem:init()
    self.filter = tiny.requireAll('isCutscene')
    self.isCutsceneSystem = true
    self.input = Input()
    self.input:bind('mouse1', 'left_click')

    Signal.register('startCutscene', function(cutsceneType)
        Global.currentLevelDefinition = Global.levelDefinitions[Global.currentLevel]
        Global.isCutscene = true
        Global.currentGame = nil
    end)
end

function CutsceneControlSystem:preProcess(dt)
end

function CutsceneControlSystem:postProcess(dt)
end

local endCutscene = function()
    if Global.isGameWon then return end

    Global.isCutscene = false
    Global.isGameOver = false
    Signal.emit('startLevel', Global.currentLevel)
    Signal.emit('transitionMusic', 'intense', 1)
end

function CutsceneControlSystem:process(e, dt)
    if not Global.isCutscene then return end
    e.behavior:update(dt)

    if self.input:released('left_click') then
        if e.behavior.frame.skipTo then
            e.behavior.setState(e.behavior, e.behavior.frame.skipTo)
            return
        end
    end

    if e.behavior.state == 'endCutscene' then
        if Global.isGameWon then
            e.behavior.setState(e.behavior, 'enterTheEnd')
        else
            endCutscene()
        end
    end
end

return CutsceneControlSystem
