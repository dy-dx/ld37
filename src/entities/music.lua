-- local gamestate = require "lib.gamestate"

local Music = Class{}

function Music:init()
    self.defaultVolume = 0.4
    self.themes = {
        intense = {
            audio = love.audio.newSource('assets/sounds/intense10min.mp3'),
            volume = 0
        },
        calm = {
            audio = love.audio.newSource('assets/sounds/calm10min.mp3'),
            volume = self.defaultVolume
        }
    };
    self.calmDuration = self.themes.calm.audio:getDuration()
    self.intenseDuration = self.themes.intense.audio:getDuration()
    -- print("calm: " .. self.themes.calm.audio:getDuration())
    -- print("intense: " .. self.themes.intense.audio:getDuration())
    self.themes.intense.audio:setVolume(self.themes.intense.volume)
    self.themes.intense.audio:setLooping(true)
    self.themes.intense.audio:play()
    self.themes.calm.audio:setVolume(self.themes.calm.volume)
    self.themes.calm.audio:setLooping(true)
    self.themes.calm.audio:play()
    --for key,value in pairs(self.themes) do
    --    print(value)
    --    --if value ==  then
    --        --value.audio:setLooping(true)
    --    value.audio:setVolume(value.volume)
    --    value.audio:play()
    --    --end
    --end
    self.isMusic = true

    self.transitionCooldown = 0
    self.transitionTime = 0
    self.transitionTheme = nil
    self.transitionVolume = 0
end

function Music:transition(theme, time, volume)
    self.transitionTime = time or 0.5
    self.transitionTheme = theme
    self.transitionCooldown = time or 0.5
    self.transitionVolume = volume or self.defaultVolume
end

return Music
