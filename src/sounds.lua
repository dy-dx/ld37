local theme = love.audio.newSource('assets/sounds/jamessong.mp3')
theme:setLooping(true)

Signal.register('theme', function ()
    theme:play()
end)
