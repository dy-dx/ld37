local Background = Class{}

function Background:init()
    self.plumbing = true
    self.pos = {
        x = 90,
        y = 90
    }
    self.sprite = love.graphics.newImage('assets/images/plumbingbg.png')
    self.isDead = false
end

function Background:process(dt)
end

return Background
