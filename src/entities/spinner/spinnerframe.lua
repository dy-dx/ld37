local SpinnerFrame = Class{}

function SpinnerFrame:init(pos)
    self.spinner = true
    self.pos = pos
    self.sprite = love.graphics.newImage('assets/images/edittedspinnerframe.png')
    self.offset = {
        x = self.sprite:getWidth() / 2,
        y = self.sprite:getHeight() / 2
    }
    self.isDead = false
    self.angle = 0
    self.pauseTimer = 0
    self.colors = {
        { r = 95, g = 196, b = 84, a = 255 },
        { r = 130, g = 150, b = 255, a = 255 },
        { r = 186, g = 57, b = 175, a = 255 },
        { r = 58, g = 187, b = 193, a = 255 },
        { r = 130, g = 121, b = 168, a = 255 },
        { r = 244, g = 197, b = 66, a = 255 },
    }
    self.isSpinnerFrame = true

end

function SpinnerFrame:getSelected()
    return math.ceil((table.getn(self.colors) * (math.pi * 2 - self.angle)) / (math.pi * 2))
end

function SpinnerFrame:pause(t)
    self.pauseTimer = t
end

function SpinnerFrame:process(dt)
    self.pauseTimer = self.pauseTimer - dt
    if(self.pauseTimer < 0) then
        self.pauseTimer = 0
    end

    if (not (self.pauseTimer == 0)) then return end

    self.angle = (self.angle + math.pi * 2 * dt) % (math.pi * 2)
    self.rot = (math.pi * 2) - self.angle
end

return SpinnerFrame
