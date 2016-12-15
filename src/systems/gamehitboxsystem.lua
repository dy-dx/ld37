local Utils = require 'utils'

local GameHitboxSystem = tiny.processingSystem(Class{})

function GameHitboxSystem:init()
    self.filter = tiny.requireAll('hitbox', 'activatable')
    self.input = Input()
    self.input:bind('mouse1', 'left_click')
end

function GameHitboxSystem:preProcess(dt)
end

function GameHitboxSystem:postProcess(dt)
end

function GameHitboxSystem:process(e, dt)
    if Global.currentGame or not self.input:pressed('left_click') then return end

    local clickX, clickY = love.mouse.getPosition()

    local point = {x = clickX, y = clickY}

    if Utils.isInside(point, e.hitbox) then
        if not Utils.isAnActiveGame(e.gName) then
            print("you can't play that game yet greg")
            return
        end

        Signal.emit("blip")

        -- printTable(e)
        Global.timeSinceOverlayOpened = love.timer.getTime()
        Global.currentGame = e.gName
    end
end

return GameHitboxSystem
