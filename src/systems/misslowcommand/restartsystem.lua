local Utils = require 'utils'

local Background = require 'entities/misslowcommand/background'
local Ship = require 'entities/misslowcommand/ship'

RestartSystem = tiny.processingSystem(Class{})


function startLevel()
    if not Utils.has_value(Global.currentLevelDefinition.activeGames, 'misslowcommand') then
        return
    end

    -- world:addEntity(Background())
    world:addEntity(Ship())
end

function RestartSystem:init()
    self.filter = tiny.requireAll('misslowcommand')
    Signal.register('startLevel', function()
        self.rampage = true
    end)
end

function RestartSystem:preProcess(dt)
end

function RestartSystem:postProcess(dt)
    if self.rampage then
        self.rampage = false
        startLevel()
    end
end

function RestartSystem:process(e, dt)
    if self.rampage then
        world:remove(e)
    end
end

return RestartSystem
