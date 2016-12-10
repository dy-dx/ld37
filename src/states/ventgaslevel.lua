local VentGas = require 'entities/ventgas'

local LevelVentGas = Class{}
function LevelVentGas:init()
end

function LevelVentGas:load()
    -- ordering of systems really matters
    world = tiny.world(
        -- draw systems
        require ("systems/drawsystems/drawventgassystem")(),
        require ("systems/ventgascontrolsystem")()
    )
    world:addEntity(VentGas())
end

return LevelVentGas
