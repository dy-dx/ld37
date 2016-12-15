-- local gamestate = require "lib.gamestate"

local NavPanel = Class{}

function NavPanel:init()
    self.isNavPanel = true

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

    self.planetRadius = 10
    self.leftButtonDown = false
    self.rightButtonDown = false
    self.leftButtonSprite = love.graphics.newImage('assets/images/navpanel/button_up.png')
    self.leftButtonDownSprite = love.graphics.newImage('assets/images/navpanel/button_upPressed.png')
    self.rightButtonSprite = love.graphics.newImage('assets/images/navpanel/button_down.png')
    self.rightButtonDownSprite = love.graphics.newImage('assets/images/navpanel/button_downPressed.png')
    self.panelSprite = love.graphics.newImage('assets/images/navpanel/panel_transparent.png')
    self.lcdpos = {x = 253, y = 511, w = 400, h = 80}
    self.shipTipX = nil
    self.shipTipY = nil
    self:resetState()

    Signal.register('startCutscene', function()
        self:resetState()
    end)
    Signal.register('startLevel', function(level)
        self:resetState()
    end)
end

function NavPanel:resetState()
    self.pos = {x = 100, y = 500, w = 600, h = 100}
    self.levelDuration = Global.currentLevelDefinition.duration
    self.secondsSinceDeparture = 0
    self.rotation = 0
    self.shipYOffset = 0
end

return NavPanel
