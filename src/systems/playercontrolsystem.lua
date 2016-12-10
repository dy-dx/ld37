local Shell = require 'entities/misslowcommand/shell'

PlayerControlSystem = tiny.processingSystem(Class{})

function PlayerControlSystem:init()
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
    if self.input:pressed("mouse1") then
        -- self.mouseDown = true
        -- if self.mouseDown then
        local x, y = love.mouse.getPosition()
        world:addEntity(Shell(x, y))
        -- end
    end

    -- if self.input:up("mouse1") then
    --     self.mouseDown = false
    -- end
end

return PlayerControlSystem
