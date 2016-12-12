local Environment = require 'entities/environment'
local Panel = require 'entities/panel'
local Overlay = require 'entities/overlay'
local NavPanel = require 'entities/navpanel'
local VentGas = require 'entities/ventgas'
local DebugInfo = require 'entities/debuginfo'
local Text = require 'entities/Text'
local CrewMemberEngineer = require 'entities/crewmemberengineer'
local CrewMemberDoctor = require 'entities/crewmemberdoctor'
local CrewMemberSecurity = require 'entities/crewmembersecurity'
local CrewMemberPilot = require 'entities/crewmemberpilot'
local AlertStatusBox = require 'entities/alertstatusbox'

local Level = Class{}
function Level:init()
end

-- Don't be tempted! Until Dec 12th
Global = {
    currentGame = nil,
    isDebug = true,
    isGameOver = false,
    timeSinceOverlayOpened = 0 -- hack for overlay
}

local text = Text('Hello Commander.', 10000);

Signal.register('write', function(s, speed)
    text:write(s, speed)
end)

Signal.register('writeMore', function(s, speed)
    text:writeMore(s, speed)
end)

function Level:load()
    -- ordering of systems really matters
    world = tiny.world(
        require ("systems/misslowcommand/playercontrolsystem")(),
        require ("systems/plumbing/playercontrolsystem")(),
        require ("systems/navpanelcontrolsystem")(),
        require ("systems/gamehitboxsystem")(),
        require ("systems/misslowcommand/motionsystem")(),
        require ("systems/misslowcommand/collisionsystem")(),
        require ("systems/ventgascontrolsystem")(),
        require ("systems/spinner/spinnersystem")(),
        require ("systems/plumbing/plumbingsystem")(),

        -- draw systems

        require ("systems/drawsystems/spritesystem")(),
        require ("systems/drawsystems/textsystem")(),

        require ("systems/drawsystems/debughitboxsystem")(),
        require ("systems/drawsystems/drawnavpanelsystem")(),

        require ("systems/overlayInputSystem")(),
        require ("systems/drawsystems/spinnerdrawsystem")(),
        require ("systems/drawsystems/plumbingsystem")(),
        require ("systems/drawsystems/drawventgassystem")(),
        require ("systems/drawsystems/misslowspritesystem")(),
        require ("systems/drawsystems/panelsystem")(),

        require ("systems/overlaySystem")(),

        -- let this go last
        require ("systems/drawsystems/drawdebuginfosystem")()
    )



    world:addEntity(Environment()) -- background layer, goes first
    world:addEntity(Overlay())
    world:addEntity(text)

    world:addEntity(NavPanel())
    world:addEntity(VentGas())
    world:addEntity(CrewMemberEngineer())
    world:addEntity(CrewMemberDoctor())
    world:addEntity(CrewMemberSecurity())
    world:addEntity(CrewMemberPilot())
    alerts = AlertStatusBox({
        PIPES = "FINE",
        SECURITY = "VERY NOT SAFE",
        GASSES = "IN DIRE NEED OF VENTING",
    })
    Signal.register(
        'set-alert-status',
        function(game, level)
            alerts:setAlertStatus(game, level)
        end)
    world:addEntity(alerts)
    world:addEntity(Panel({x = 10, y = 300, w = 100, h = 250}, "plumbing"))
    world:addEntity(Panel({x = 80, y = 160, w = 160, h = 220}, "ventgas"))
    world:addEntity(Panel({x = 560, y = 160, w = 160, h = 220}, "spinner"))
    world:addEntity(Panel({x = 690, y = 300, w = 100, h = 250}, "misslowcommand"))


    if Global.isDebug then
        world:addEntity(DebugInfo())
    end

    Signal.emit('set-alert-status', "DAD", "NOT MY REAL")
    -- todo
    require 'signalhandlers'
end

return Level
