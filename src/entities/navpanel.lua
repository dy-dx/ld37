-- local gamestate = require "lib.gamestate"

local NavPanel = Class{}

function NavPanel:init()
    self.isNavPanel = true
    self.levelDuration = 30
    self.secondsSinceDeparture = 0
end

return NavPanel
