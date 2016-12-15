local SpinnerFrame = Class{}

function SpinnerFrame:init(center)
    self.spinner = true
    self.sprite = love.graphics.newImage('assets/images/pills/wheel.png')
    self.pos = center;

    self.offset = {
        x = self.sprite:getWidth() / 2 ,
        y = self.sprite:getHeight() / 2 - 1
    }
    self.isDead = false
    self.angle = 0
    self.pauseTimer = 0
    self.colors = {
        love.graphics.newImage('assets/images/pills/triangle.png'),
        love.graphics.newImage('assets/images/pills/square.png'),
        love.graphics.newImage('assets/images/pills/sphere.png'),
        love.graphics.newImage('assets/images/pills/oval.png'),
        love.graphics.newImage('assets/images/pills/donut.png'),
        love.graphics.newImage('assets/images/pills/hex.png')
    }

    self.isSpinnerFrame = true

    self.buttonUpSprite = love.graphics.newImage('assets/images/pills/wheelbutton_on.png')
    self.buttonDownSprite = love.graphics.newImage('assets/images/pills/wheelbutton_off_fixed.png')
    self.buttonCenter = center
    self.buttonCooldownTimer = 0
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

    local wheelSpeed = Global.currentLevelDefinition.spinner.wheelSpeed * 0.1
    -- wheelSpeed == 1 was the default
    self.angle = (self.angle + wheelSpeed * math.pi * 2 * dt) % (math.pi * 2)
    self.rot = (math.pi * 2) - self.angle
end

return SpinnerFrame
