-- local gamestate = require "lib.gamestate"

local Shell = Class{}
Shell.SPEED = 1
start_x = 400
start_y = 500

function Shell:init(dest_x, dest_y)
    self.misslowcommand = true
    self.isShell = true
    self.destination = {x = dest_x, y = dest_y}

    local offset_x = dest_x - start_x
    local offset_y = dest_y - start_y
    local total_hypotenuse = math.sqrt(offset_x * offset_x + offset_y * offset_y)
    angle = math.atan2(offset_y, offset_x)

    self.velocity = {
        x = math.cos(angle) * Shell.SPEED,
        y = math.sin(angle) * Shell.SPEED,
    }
    print(self.velocity.x)
    self.pos = {x = start_x, y = start_y}
    self.sprite = love.graphics.newImage('assets/images/bullet.png')
end

-- function Shell:process()
-- end

return Shell
