local bump = require('vendor/bump')
local Environment = require 'entities/environment'
local Panel = require 'entities/panel'
local NavPanel = require 'entities/navpanel'
local MisslowCommandPlayer = require 'entities/misslowcommand/player'


local Level = Class{}
function Level:init()
end

function Level:load()
    -- ordering of systems really matters
    world = tiny.world(
        require ("systems/playercontrolsystem")(),
        require ("systems/misslowcommand/motionsystem")(),
        require ("systems/misslowcommand/collisionsystem")(),
        -- draw systems
        require ("systems/drawsystems/panelsystem")(),
        require ("systems/drawsystems/debughitboxsystem")(),
        require ("systems/drawsystems/spritesystem")("misslowcommand")
    )
    print("beginning of world")

    -- fixme
    world:addEntity(NavPanel())
    world:addEntity(MisslowCommandPlayer())
    world:addEntity(Environment())
end

return Level
