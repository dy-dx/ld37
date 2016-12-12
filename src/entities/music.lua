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

    for key,value in pairs(self.themes) do
        value.audio:setLooping(true)
        value.audio:setVolume(value.volume)
        value.audio:play()
    end
    self.isMusic = true

    self.transitionCooldown = 0;
    self.transitionTime = 0;
    self.transitionTheme = nil;
    self.transitionVolume = 0;
end

function Music:transition(theme, time, volume)
    self.transitionTime = time
    self.transitionTheme = theme
    self.transitionCooldown = time
    self.transitionVolume = volume
end

return Music
