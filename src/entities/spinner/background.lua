local Background = Class{}

function Background:init()
    self.spinner = true
    self.pos = {
        x = 90,
        y = 79
    }
    self.sprite = love.graphics.newImage('assets/images/misslowbg.png')
    self.isDead = false
    print("Background initialized")
end

function Background:process(dt)
    print("background is processed")
end


return Background
