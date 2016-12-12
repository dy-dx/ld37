local Shell = require 'entities/misslowcommand/shell'

PlayerControlSystem = tiny.processingSystem(Class{})

function PlayerControlSystem:init()
    self.name = "misslowcommand"
    self.filter = tiny.requireAll('controllable')
    self.input = Input()
    self.input:bind('mouse1', 'mouse1')

    -- self.mouseDown = false
end

function PlayerControlSystem:preProcess(dt)
end

function PlayerControlSystem:postProcess(dt)
end

function PlayerControlSystem:process(e, dt)
    if Global.currentGame ~= self.name or e.gName ~= self.name then
        return
    end
    if self.input:pressed("mouse1") then
        -- self.mouseDown = true
        -- if self.mouseDown then
        -- Signal.emit('writeMore', "Yea get'em", 10000)

        local x, y = love.mouse.getPosition()
        if 90 < x and x < 710 and 80 < y and y < 460 then
            Signal.emit('fire')
            world:addEntity(Shell(x, y))
        end
        -- end
    end

    -- if self.input:up("mouse1") then
    --     self.mouseDown = false
    -- end
end

return PlayerControlSystem
