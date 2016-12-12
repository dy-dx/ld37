Signal.register('gameover', function(gamename)
    if Global.isGameOver or Global.isGameWon or Global.isGodMode then return end
    Global.isGameOver = true
    -- todo
    print("Game Over!")
end)
