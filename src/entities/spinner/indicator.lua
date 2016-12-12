local SPIN_RADIUS = 115

local Indicator = Class{}

function Indicator:init()
    self.spinner = true
    self.isIndicator = true
    self.angle = 0
    self.pos = {}
    self.sprite = love.graphics.newImage('assets/images/bullet.png')
    self.offset = {
        x = self.sprite:getWidth() / 2,
        y = self.sprite:getHeight() / 2
    }
    self.isDead = false
    self.colors = {
        { r = 58, g = 187, b = 193, a = 255 },
        { r = 130, g = 121, b = 168, a = 255 },
        { r = 244, g = 197, b = 66, a = 255 },
        { r = 95, g = 196, b = 84, a = 255 },
        { r = 130, g = 150, b = 255, a = 255 },
        { r = 186, g = 57, b = 175, a = 255 }
    }
end

function Indicator:getSelected()
    return math.ceil((table.getn(self.colors) * (math.pi * 2 - self.angle)) / (math.pi * 2))
end

function Indicator:process(dt)
    self.angle = (self.angle + math.pi * 2 * dt) % (math.pi * 2)
    self.pos = {
        x = SPIN_RADIUS * math.cos(self.angle) + 250,
        y = SPIN_RADIUS * math.sin(self.angle) + 250
    }
end

return Indicator
