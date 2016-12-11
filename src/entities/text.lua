-- local gamestate = require "lib.gamestate"
local Utils = (require 'utils')()

local Text = Class{}

function Text:init(text, speed)
    self.text = text
    self.speed = speed or 1000
    self.index = 0;
    self.time = 0
    self.textHeight = 150
    self.maxWidth = 200
end

function Text:write(text, speed)
    self.text = text
    self.speed = speed or 1000
    self.time = 0
    self.maxWidth = 200
end

return Text
