NavPanelControlSystem = tiny.processingSystem(Class{})

function NavPanelControlSystem:init()
    self.filter = tiny.requireAll('isNavPanel')
    self.input = Input()
    self.input:bind('mouse1', 'left_click')
end

function NavPanelControlSystem:preProcess(dt)
end

function NavPanelControlSystem:postProcess(dt)
end

function NavPanelControlSystem:process(e, dt)
    if self.input:released('left_click') then
       x, y = love.mouse.getPosition()
       print(x, y)
    end
end

return NavPanelControlSystem
