local bump = require('vendor/bump')
local Environment = require 'entities/environment'
local Panel = require 'entities/panel'

local Level = Class{}
function Level:init()
end

function Level:load()
    -- ordering of systems really matters
    world = tiny.world(
        require ("systems/playercontrolsystem")(),
        require ("systems/spritesystem")(),
        require ("systems/drawsystems/panelsystem")(),
        require ("systems/drawsystems/debughitboxsystem")(),
        require ("systems/drawsystems/environmentsystem")()
    )
    print("beginning of world")

    -- fixme
    world:addEntity(Environment())
end

return Level
