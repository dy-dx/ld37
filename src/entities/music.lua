-- local gamestate = require "lib.gamestate"

local Music = Class{}

function Music:init()
    self.themes = {
        intense = {
            audio = love.audio.newSource('assets/sounds/loop_intense.mp3'),
            volume = 0
        },
        calm = {
            audio = love.audio.newSource('assets/sounds/loop_calm.mp3'),
            volume = 0.9
        }
    };
    self.calmDuration = self.themes.calm.audio:getDuration() - 0.13
    self.intenseDuration = self.themes.intense.audio:getDuration()
    print("calm: " .. self.themes.calm.audio:getDuration())
    print("intense: " .. self.themes.intense.audio:getDuration())
    self.themes.calm.audio:setVolume(0.9)
    --self.themes.calm.audio:setLooping(true)
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
    self.transitionTime = time
    self.transitionTheme = theme
    self.transitionCooldown = time
    self.transitionVolume = volume
end

return Music
