local bump = require('vendor/bump')
local CollisionBox = require 'entities/collisionbox'
local Environment = require 'entities/environment'
local Panel = require 'entities/panel'

local Level = Class{}
function Level:init()
end

function Level:load()
    local bumpWorld = bump.newWorld(32)

    -- globals: i'll fix this, don't worry bout it
    -- ordering of systems really matters
    world = tiny.world(
        require ("systems/playercontrolsystem")(),
        require ("systems/spritesystem")(),
        require ("systems/environmentsystem")(),
        require ("systems/panelsystem")(),
        require ("systems/debughitboxsystem")()
    )
    print("beginning of world")

    -- fixme
    world:addEntity(Environment())
end

return Level
