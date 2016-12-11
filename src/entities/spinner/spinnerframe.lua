local SpinnerFrame = Class{}

function SpinnerFrame:init()
    self.spinner = true
    self.pos = {
        x = 200,
        y = 250
    }
    self.sprite = love.graphics.newImage('assets/images/spinnerframe.png')
    self.offset = {
        x = self.sprite:getWidth() / 2,
        y = self.sprite:getHeight() / 2
    }
    self.isDead = false
end

function SpinnerFrame:process(dt)
end

return SpinnerFrame
