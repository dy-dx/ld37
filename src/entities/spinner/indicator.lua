local SPIN_RADIUS = 115

local Indicator = Class{}

function Indicator:init()
    self.spinner = true
    self.angle = 0
    self.pos = {}
    self.sprite = love.graphics.newImage('assets/images/bullet.png')
    self.offset = {
        x = self.sprite:getWidth() / 2,
        y = self.sprite:getHeight() / 2
    }
    self.isDead = false
end

function Indicator:process(dt)
    print("processing")
    self.angle = (self.angle + math.pi * 2 * dt) % (math.pi * 2)
    self.pos = {
        x = SPIN_RADIUS * math.cos(self.angle) + 200,
        y = SPIN_RADIUS * math.sin(self.angle) + 250
    }
end

return Indicator
