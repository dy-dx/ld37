-- local gamestate = require "lib.gamestate"

local NavPanel = Class{}

function NavPanel:init()
    self.isNavPanel = true
    self.levelDuration = 30
    self.secondsSinceDeparture = 0
    self.rotation = 0
    self.shipYOffset = 0

    self.pos = {x = 100, y = 500, w = 600, h = 100}

    self.lcdpos = {x = 250, y = 510, w = 400, h = 80}

    self.leftButton = {
        x = 150,
        y = 505,
        w = 40,
        h = 40
    }

    self.rightButton = {
        x = 150,
        y = 555,
        w = 40,
        h = 40
    }
end

return NavPanel
