MusicSystem = tiny.processingSystem(Class{})

function MusicSystem:init()
    self.filter = tiny.requireAll('isMusic')
end

function MusicSystem:preProcess(dt)

end

function MusicSystem:postProcess(dt)
end

function MusicSystem:process(e, dt)
    --if(e.transitionCooldown <  0) then
    --    for key,value in pairs(e.themes) do
    --        if(e.transitionTheme == key) then
    --            value.volume = e.transitionVolume
    --        else
    --            value.volume = 0
    --        end
    --    end

    --    e.transitionCooldown = 0
    --end

    --if(not (e.transitionCooldown == 0)) then
    --    e.transitionCooldown = e.transitionCooldown - dt
    --    local transitionPercent = 1 - ((e.transitionCooldown) / e.transitionTime);

    --    for key,value in pairs(e.themes) do
    --        local fromVolume = value.volume

    --        local toVolume
    --        if(e.transitionTheme == key) then
    --            toVolume = e.transitionVolume
    --        else
    --            toVolume = 0
    --        end

    --        value.audio:setVolume(fromVolume * (1 - transitionPercent) + toVolume * transitionPercent)
    --    end
    --end
    e.transitionCooldown = e.transitionCooldown + dt
    if e.transitionCooldown >= e.calmDuration then -- time passed since our e.calmDuration second long song
        e.themes.calm.audio:play() -- force song to replay
        e.themes.calm.audio:seek(e.transitionCooldown - e.calmDuration, 'seconds') -- jump to position
        e.transitionCooldown = e.transitionCooldown - e.calmDuration
    end
end

return MusicSystem
