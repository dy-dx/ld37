-- local gamestate = require "lib.gamestate"

local NavPanel = Class{}

function NavPanel:init()
    self.isNavPanel = true
    self.levelDuration = 30
    self.secondsSinceDeparture = 0
    self.rotation = 0
    self.shipYOffset = 0

    self.pos = {x = 100, y = 450, w = 600, h = 150}

    self.lcdpos = {x = 250, y = 480, w = 400, h = 90}

    self.leftButton = {
        x = 150,
        y = 470,
        w = 50,
        h = 50
    }

    self.rightButton = {
        x = 150,
        y = 530,
        w = 50,
        h = 50
    }
end

return NavPanel
