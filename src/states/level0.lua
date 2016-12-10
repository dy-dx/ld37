local bump = require('vendor/bump')
local Environment = require 'entities/environment'
local Panel = require 'entities/panel'
local NavPanel = require 'entities/navpanel'

local Level = Class{}
function Level:init()
end

function Level:load()
    -- ordering of systems really matters
    world = tiny.world(
        require ("systems/playercontrolsystem")(),
        -- draw systems
        require ("systems/drawsystems/panelsystem")(),
        require ("systems/drawsystems/debughitboxsystem")(),
        require ("systems/drawsystems/environmentsystem")(),
        require ("systems/drawsystems/drawnavpanelsystem")(),
        require ("systems/drawsystems/spritesystem")()
    )

    -- fixme
    world:addEntity(NavPanel())
    world:addEntity(Environment())
end

return Level
