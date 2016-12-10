EnvironmentSystem = tiny.processingSystem(Class{})

function EnvironmentSystem:init()
	self.filter = tiny.requireAll('isEnvironment')
	self.isDrawingSystem = true
end

function EnvironmentSystem:preProcess(dt)
end

function EnvironmentSystem:postProcess(dt)
end

function EnvironmentSystem:process(e, dt)
	printTable(e)
    e:draw(dt)
end

return EnvironmentSystem
