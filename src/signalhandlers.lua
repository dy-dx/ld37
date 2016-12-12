Signal.register('gameover', function(gamename)
    if Global.isGameOver or Global.isGameWon or Global.isGodMode then return end
    Global.isGameOver = true
    -- todo
    print("Game Over! you lost the " .. tostring(gamename) .. " game")
    Signal.emit('write', "You lost the " .. tostring(gamename) .. " game", 150000)
end)

Signal.register('startCutscene', function(level)
    Global.currentLevelDefinition = Global.levelDefinitions[Global.currentLevel]
    Global.isCutscene = true
    -- todo, display text, and after text is finished, then do the following:
    -- Global.isCutscene = false
    -- Signal.emit('startLevel', Global.currentLevel)
end)
