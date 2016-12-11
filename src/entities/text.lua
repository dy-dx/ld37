-- local gamestate = require "lib.gamestate"
local Utils = (require 'utils')()

local Text = Class{}

function Text:init(text, speed)
    self.text = text
    self.speed = speed or 1000
    self:reset()
end

function Text:reset()
    self.time = 0
    self.textHeight = 150
    self.maxWidth = 200
    self.prevTextLen = 0
end

function Text:write(text, speed)
    if(self.charactersDisplayed < string.len(self.text)) then return end
    self:reset()
    self.text = text
    self.speed = speed or 1000
end

return Text
