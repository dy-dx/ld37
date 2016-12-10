PlayerControlSystem = tiny.processingSystem(Class{})

function PlayerControlSystem:init()
    self.filter = tiny.requireAll('controllable')
    self.input = Input()
    self.input:bind('left', 'left')
    self.input:bind('right', 'right')
    self.input:bind('up', 'up')
    self.input:bind('z', 'z')
end

function PlayerControlSystem:preProcess(dt)
end

function PlayerControlSystem:postProcess(dt)
end

function PlayerControlSystem:process(e, dt)
end

return PlayerControlSystem
