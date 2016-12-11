local explosion = love.audio.newSource('assets/sounds/Explosion10.wav')
local fire = love.audio.newSource('assets/sounds/Laser_Shoot48.wav')
local ded = love.audio.newSource('assets/sounds/ShipHit15.wav')
local talk = love.audio.newSource('assets/sounds/Talk41.wav')

local theme = love.audio.newSource('assets/sounds/jamessong.mp3')
theme:setLooping(true)

Signal.register('theme', function ()
    theme:play()
end)

Signal.register('explosion', function ()
    explosion:play()
end)

Signal.register('fire', function ()
    fire:play()
end)

Signal.register('ded', function ()
    ded:play()
end)

Signal.register('talk', function ()
    talk:play()
end)
