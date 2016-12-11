local Utils = require 'utils'

GameHitboxSystem = tiny.processingSystem(Class{})

function GameHitboxSystem:init()
    self.filter = tiny.requireAll('hitbox', 'activatable')
    self.input = Input()
    self.input:bind('mouse1', 'left_click')
    print("init run")
end

function GameHitboxSystem:preProcess(dt)
end

function GameHitboxSystem:postProcess(dt)
end

function GameHitboxSystem:process(e, dt)
    if not Global.currentGame and self.input:released('left_click') then
        clickX, clickY = love.mouse.getPosition()

        local point = {x = clickX, y = clickY}

        if(Utils.isInside(point, e.hitbox) and not Global.currentGame) then
            printTable(e)
            Global.currentGame = e.gName
        end
    end
end

return GameHitboxSystem
