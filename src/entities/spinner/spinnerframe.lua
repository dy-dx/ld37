local SpinnerFrame = Class{}

function SpinnerFrame:init(pos)
    self.spinner = true
    self.pos = pos
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
