-- local gamestate = require "lib.gamestate"
local Utils = (require 'utils')()

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
    Utils.printFilled(self.hitbox, {r = 0, g = 255, b = 0}, 'line')
end

return Panel
