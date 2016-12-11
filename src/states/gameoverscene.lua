local DebugInfo = require 'entities/debuginfo'
local Cutscene = require 'entities/cutscene'

local Level = Class{}

function Level:init()
    -- Don't be tempted! Until Dec 12th
    Global = {
        currentGame = nil,
        isDebug = true,
        isGameOver = true,
        timeSinceOverlayOpened = 0
    }
end


function Level:load()
    -- ordering of systems really matters
    world = tiny.world(

        -- draw systems
        require ("systems/drawsystems/cutscenedrawsystem")(),

        -- let this go last
        require ("systems/drawsystems/drawdebuginfosystem")()
    )

    world:addEntity(Cutscene())

    if Global.isDebug then
        world:addEntity(DebugInfo())
    end

    -- todo
    require 'signalhandlers'
end

return Level
