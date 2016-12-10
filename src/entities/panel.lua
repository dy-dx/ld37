-- local gamestate = require "lib.gamestate"

local Panel = Class{}

function Panel:init(hitbox, gameName)

    self.isPanel = true
    self.controllable = true
    self.activatable = true
    self.gName = gameName

    print('game')
    print('self.gName'.. self.gName)
    print(game)

    self.hitbox = hitbox
end

function Panel:draw(dt)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.rectangle('fill', self.hitbox.x, self.hitbox.y, self.hitbox.w, self.hitbox.h)
    love.graphics.setColor(255, 255, 255)
end

return Panel
