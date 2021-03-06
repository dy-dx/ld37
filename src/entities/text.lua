-- local gamestate = require "lib.gamestate"
local Utils = (require 'utils')()

local Text = Class{}

function Text:init(text, speed)
    self.text = text
    self.speed = speed or 20000
    self:reset()
end

function Text:reset()
    self.charactersDisplayed = 0
    self.time = 0
    self.textX = 270
    self.textY = 40
    self.maxWidth = 200
    self.prevTextLen = 0
    self.savedText = {}
end

function Text:write(text, speed)
    if(self.charactersDisplayed < string.len(self.text)) then return end
    self:reset()
    self.text = text
    self.speed = speed or 20000
end

function Text:writeMore(text, speed)
    if(self.charactersDisplayed < string.len(self.text)) then return end
    local tmpText = lume.concat(self.savedText, {self.text})
    self:reset()
    self.savedText = tmpText
    self.text = text
    self.speed = speed or 20000
end

return Text
