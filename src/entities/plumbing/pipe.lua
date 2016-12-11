local Pipe = Class{}

local offsett = {
    x = 125,
    y = 125
}

function Pipe:init(x, y, rotation)
    self.plumbing = true
    self.pos = {
        x = x * 50 + offsett.x,
        y = y * 50 + offsett.y
    }
    self.rot = rotation * math.pi / 2
    self.sprite = love.graphics.newImage('assets/images/pipeLD.png')
    self.offset = {
        x = self.sprite:getWidth() / 2,
        y = self.sprite:getHeight() / 2
    }
    self.isDead = false
end

function Pipe:process(dt)
end

return Pipe
