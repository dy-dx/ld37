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

        require ("systems/overlaySystem")(),
        require ("systems/overlayInputSystem")()
    )

    local windowWidth  = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()
    local padding = 40;

    -- fixme
    world:addEntity(
        Overlay({
            x = padding,
            y = padding,
            w = windowWidth - 2 * padding,
            h = windowHeight - 2 * padding
        }));

    world:addEntity(NavPanel())
    world:addEntity(Panel({x = 90, y = 120, w = 110, h = 200}, "TESTGAME")) -- needs to take panel graphis
    world:addEntity(Environment())
end

return Level
