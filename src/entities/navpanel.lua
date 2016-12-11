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
        y = 502,
        w = 50,
        h = 50
    }

    self.rightButton = {
        x = 150,
        y = 551,
        w = 50,
        h = 50
    }

    self.leftButtonDown = false
    self.rightButtonDown = false
    self.leftButtonSprite = love.graphics.newImage('assets/images/navpanel/button_up.png')
    self.leftButtonDownSprite = love.graphics.newImage('assets/images/navpanel/button_upPressed.png')
    self.rightButtonSprite = love.graphics.newImage('assets/images/navpanel/button_down.png')
    self.rightButtonDownSprite = love.graphics.newImage('assets/images/navpanel/button_downPressed.png')
    self.panelSprite = love.graphics.newImage('assets/images/navpanel/panel.png')
end

return NavPanel
