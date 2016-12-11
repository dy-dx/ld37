Signal.register('gameover', function ()
    if Global.isGameOver then return end
    Global.isGameOver = true
    -- todo
    print("Game Over!")
end)
