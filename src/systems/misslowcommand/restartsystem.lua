local Utils = require 'utils'

local Background = require 'entities/misslowcommand/background'
local Ship = require 'entities/misslowcommand/ship'

RestartSystem = tiny.processingSystem(Class{})


function startLevel()
    if not Utils.isAnActiveGame('misslowcommand') then
        return
    end

    world:addEntity(Ship())
end

function RestartSystem:init()
    self.filter = tiny.requireAll('misslowcommand')

    self.background = Background()
    self.backgroundinit = false
    Signal.register('startLevel', function()
        self.rampage = true
    end)
end

function RestartSystem:preProcess(dt)
    if(not self.backgroundinit) then
        world:addEntity(self.background)
        self.backgroundinit = true
    end
end

function RestartSystem:postProcess(dt)
    if self.rampage then
        self.rampage = false
        startLevel()
    end
end

function RestartSystem:process(e, dt)
    if self.rampage and not e.isBackground then
        world:remove(e)
    end
end

return RestartSystem
