local explosion = love.audio.newSource('assets/sounds/Explosion10.wav')
local fire = love.audio.newSource('assets/sounds/Laser_Shoot48.wav')
local ded = love.audio.newSource('assets/sounds/ShipHit15.wav')
local talk = love.audio.newSource('assets/sounds/Talk41.wav')
local blip = love.audio.newSource('assets/sounds/Blip_Select67.wav')

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

Signal.register('blip', function ()
    blip:play()
end)
