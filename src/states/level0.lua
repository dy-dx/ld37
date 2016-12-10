local Environment = require 'entities/environment'
local Panel = require 'entities/panel'
local Overlay = require 'entities/overlay'
local NavPanel = require 'entities/navpanel'
local VentGas = require 'entities/ventgas'

local Level = Class{}
function Level:init()
end

Global = {
    currentGame = nil
}

function Level:load()
    -- ordering of systems really matters
    world = tiny.world(
        require ("systems/misslowcommand/playercontrolsystem")(),
        require ("systems/navpanelcontrolsystem")(),
        require ("systems/gamehitboxsystem")(),
        require ("systems/misslowcommand/motionsystem")(),
        require ("systems/misslowcommand/collisionsystem")(),
        require ("systems/ventgascontrolsystem")(),

        -- draw systems

        require ("systems/drawsystems/spritesystem")(),
        require ("systems/drawsystems/panelsystem")(),
        require ("systems/drawsystems/debughitboxsystem")(),
        require ("systems/drawsystems/drawnavpanelsystem")(),

        require ("systems/overlaySystem")(),
        require ("systems/overlayInputSystem")(),
        require ("systems/drawsystems/drawventgassystem")(),
        require ("systems/drawsystems/misslowspritesystem")()
    )

    -- fixme
    world:addEntity(Overlay());

    world:addEntity(NavPanel())
    world:addEntity(VentGas())
    world:addEntity(Panel({x = 80, y = 160, w = 160, h = 220}, "misslowcommand")) -- needs to take panel graphis
    world:addEntity(Panel({x = 560, y = 160, w = 160, h = 220}, "ventgas"))
    world:addEntity(Panel({x = 10, y = 300, w = 100, h = 250}, "TESTGAME1"))
    world:addEntity(Panel({x = 690, y = 300, w = 100, h = 250}, "TESTGAME2"))
    world:addEntity(Environment())

    -- todo
    require 'signalhandlers'
end

return Level
