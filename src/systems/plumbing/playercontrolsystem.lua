PlayerControlSystem = tiny.processingSystem(Class{})

function PlayerControlSystem:init()
    self.name = "plumbing"
    self.filter = tiny.requireAll('controllable')
    self.input = Input()
    self.input:bind('mouse1', 'mouse1')
end

function PlayerControlSystem:preProcess(dt)
end

function PlayerControlSystem:postProcess(dt)
end

function PlayerControlSystem:process(e, dt)
    if Global.currentGame ~= self.name then
        return
    end
    if self.input:pressed("mouse1") then
        -- self.mouseDown = true
        -- if self.mouseDown then
        local x, y = love.mouse.getPosition()
        x = math.floor((x - 75) / 50)
        y = math.floor((y - 75) / 50)
        if 0 <= x and x < 10 and 0 <= y and y < 7 then
            print(x, y)
        end
    end

    -- if self.input:up("mouse1") then
    --     self.mouseDown = false
    -- end
end

return PlayerControlSystem
