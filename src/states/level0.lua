local bump = require('vendor/bump')
local sti = require "../vendor/sti.init"
local Player = require 'entities/player'
local Met = require 'entities/met'
local DrawLayer = require 'entities/layers/drawlayer'
local CollisionLayer = require 'entities/layers/collisionlayer'
local CollisionBox = require 'entities/collisionbox'

local Level = Class{}
function Level:init()
end

function Level:load()
    local bumpWorld = bump.newWorld(32)

    -- globals: i'll fix this, don't worry bout it
    world = tiny.world(
        require ("systems/playercontrolsystem")(),
        require ("systems/projectilephysicssystem")(),
        require ("systems/drawlayersystem")(),
        require ("systems/bumpphysicssystem")(bumpWorld),
        require ("systems/spritesystem")(),
        require ("systems/debughitboxsystem")()
    )

    local player = Player()
    local tileMap = sti("tiled/level1.lua", { })
    -- fixme
    Global.map = tileMap
    local drawLayer = DrawLayer(tileMap)
    local collisionlayer = CollisionLayer(tileMap, bumpWorld)

    world:addEntity(drawLayer)
    world:addEntity(collisionlayer)
    world:addEntity(player)
    world:addEntity(Met(700, 500))
end

return Level
