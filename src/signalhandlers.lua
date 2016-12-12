Signal.register('gameover', function(gamename)
    if Global.isGameOver or Global.isGameWon or Global.isGodMode then return end
    Global.isGameOver = true
    -- todo
    print("Game Over! you lost the " .. tostring(gamename) .. " game")
    Signal.emit('write', "You lost the " .. tostring(gamename) .. " game", 150000)
end)
