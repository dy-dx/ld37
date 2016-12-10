local bump = require('vendor/bump')
local Environment = require 'entities/environment'
local Panel = require 'entities/panel'
local Overlay = require 'entities/overlay'
local NavPanel = require 'entities/navpanel'

local Level = Class{}
function Level:init()
end

Global = {
    currentGame = nil
}

function Level:load()
    -- ordering of systems really matters
    world = tiny.world(
        require ("systems/playercontrolsystem")(),
        require ("systems/navpanelcontrolsystem")(),
        require ("systems/gamehitboxsystem")(),

        -- draw systems
        require ("systems/drawsystems/spritesystem")(),
        require ("systems/drawsystems/panelsystem")(),
        require ("systems/drawsystems/debughitboxsystem")(),
        require ("systems/drawsystems/drawnavpanelsystem")(),
        require ("systems/overlaySystem")()
    )

    -- fixme
    world:addEntity(Overlay()); -- needs to take game logic

    world:addEntity(NavPanel())
    world:addEntity(Panel({x = 30, y = 40, w = 50, h = 50}, "TESTGAME")) -- needs to take panel graphis
    world:addEntity(Environment())
end

return Level
