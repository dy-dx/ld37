local defaultVolume = 0.6

local explosion = love.audio.newSource('assets/sounds/Explosion10.wav')
explosion:setVolume(defaultVolume)
local fire = love.audio.newSource('assets/sounds/Laser_Shoot48.wav')
fire:setVolume(defaultVolume)
local ded = love.audio.newSource('assets/sounds/EXPLOSION_Medium_Bright_Impact_Rumble_Quick_Tail_stereo.wav')
ded:setVolume(0.4)
local talk = love.audio.newSource('assets/sounds/Talk41.wav')
talk:setVolume(defaultVolume)
local alarm = love.audio.newSource('assets/sounds/alarm.wav')
alarm:setVolume(.19)

local blip = love.audio.newSource('assets/sounds/Blip_Select67.wav')
blip:setVolume(defaultVolume)
local failBlip = love.audio.newSource('assets/sounds/Blip_Select72.wav')
failBlip:setVolume(defaultVolume)
local consoleButton = love.audio.newSource('assets/sounds/Blip_Select48.wav')
consoleButton:setVolume(defaultVolume)
local spray = love.audio.newSource('assets/sounds/MACHINE_Boiling_Molten_Metal_Furnice_loop_mono.wav')
spray:setLooping(true)
spray:setVolume(1)

local sludge = love.audio.newSource('assets/sounds/sludge.wav')
sludge:setLooping(true)
sludge:setVolume(1)

local loopwoosh = love.audio.newSource('assets/sounds/loopwoosh.wav')
loopwoosh:setLooping(true)
loopwoosh:setVolume(1)

local failBuzzer = love.audio.newSource('assets/sounds/wrongbuzzer.wav')
failBuzzer:setVolume(0.3)

Signal.register('explosion', function ()
    explosion:play()
end)

Signal.register('fire', function ()
    fire:play()
end)

Signal.register('alarm', function ()
    alarm:play()
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

Signal.register('failBuzzer', function ()
    failBuzzer:play()
end)

Signal.register('consoleButton', function ()
    consoleButton:play()
end)

Signal.register('spray', function ()
    print("playing spreay")
    spray:play()
end)

Signal.register('stopspray', function ()
    print("stopping spreay")
    spray:pause()
end)

Signal.register('woosh', function ()
    print("wooshing")
    loopwoosh:play()
end)

Signal.register('stopwoosh', function ()
    print("stopwoosh")
    loopwoosh:pause()
end)

Signal.register('sludge', function ()
    print("playing sludge")
    sludge:play()
end)

Signal.register('stopsludge', function ()
    print("stopping sludge")
    sludge:pause()
end)
