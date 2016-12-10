local bump = require('vendor/bump')
local Player = require 'entities/player'
local Met = require 'entities/met'
local CollisionBox = require 'entities/collisionbox'
local Environment = require 'entities/environment'

local Level = Class{}
function Level:init()
end

function Level:load()
    local bumpWorld = bump.newWorld(32)

    -- globals: i'll fix this, don't worry bout it
    -- ordering of systems really matters
    world = tiny.world(
        require ("systems/playercontrolsystem")(),
        require ("systems/projectilephysicssystem")(),
        require ("systems/bumpphysicssystem")(bumpWorld),
        require ("systems/spritesystem")(),
        require ("systems/environmentsystem")(),
        require ("systems/panelsystem")(),
        require ("systems/debughitboxsystem")()
    )
    print("beginning of world")

    local environment = Environment()
    local player = Player()
    
    -- fixme

    world:addEntity(environment)
end

return Level
