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

    if self.input:released('left_click') then
        clickX, clickY = love.mouse.getPosition()

        if(e.hitbox.x < clickX and
            clickX < e.hitbox.x + e.hitbox.w and
            e.hitbox.y < clickY and
            clickY < e.hitbox.y + e.hitbox.h) then

            printTable(e)


            Global.currentGame = e.gName
        end
    end
end

return GameHitboxSystem
