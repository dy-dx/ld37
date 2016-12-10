PanelSystem = tiny.processingSystem(Class{})

function PanelSystem:init()
	print("hello ispanel")
	self.filter = tiny.requireAll('isPanel')
	self.isDrawingSystem = true
end

function PanelSystem:preProcess(dt)
end

function PanelSystem:postProcess(dt)
end

function PanelSystem:process(e, dt)
	print("in panel draw system")
	print("e")
	printTable(e)
    e:draw(dt)
end

return PanelSystem
