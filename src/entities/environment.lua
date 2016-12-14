-- local gamestate = require "lib.gamestate"

local Environment = Class{}

function Environment:init()
    -- self.global = true
    self.isBackground = true
    self.isEnvironment = true
    self.pos = {x = 0, y = 0}
    self.sprite = love.graphics.newImage("assets/images/background.png")
    -- what is this for??
    Signal.emit('theme')

    self.dangerLevels = {
        nav = 1,
        ventgas = 1,
        spinner = 1,
        misslowcommand = 1,
        plumbing = 1,
    }
    Signal.register('dangerLevel', function(gamename, level)
        self.dangerLevels[gamename] = level
    end)
end

function Environment:draw(dt)
    -- WTF is this for
    self.controllable = true
end

return Environment
