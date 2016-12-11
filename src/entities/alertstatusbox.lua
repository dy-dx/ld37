-- local gamestate = require "lib.gamestate"
local Utils = (require 'utils')()

local AlertStatusBox = Class{}

function AlertStatusBox:init(gameNames)
    -- initialize game states to FINE.
    -- TODO allow for table based initialization with levels specified.

    self.status = {}
    printTable(gameNames)
    for name, level in ipairs(gameNames) do
        self.status[name] = level
    end
end

function AlertStatusBox:setAlertStatus(game, level)
    self.status[game] = level
    self:draw()
end

function AlertStatusBox:draw()
    printTable(self.status)
end

return AlertStatusBox
