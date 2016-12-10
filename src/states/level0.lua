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
        require ("systems/navpanelcontrolsystem")(),
        -- draw systems
        require ("systems/drawsystems/spritesystem")(),
        require ("systems/drawsystems/panelsystem")(),
        require ("systems/drawsystems/debughitboxsystem")(),
        require ("systems/drawsystems/drawnavpanelsystem")()
    )

    -- fixme
    world:addEntity(NavPanel())
    world:addEntity(Environment())
end

return Level
