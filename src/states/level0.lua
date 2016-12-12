local Environment = require 'entities/environment'
local Panel = require 'entities/panel'
local Overlay = require 'entities/overlay'
local NavPanel = require 'entities/navpanel'
local VentGas = require 'entities/ventgas'
local DebugInfo = require 'entities/debuginfo'
local Text = require 'entities/Text'
local Music = require 'entities/Music'
local CrewMemberEngineer = require 'entities/crewmemberengineer'
local CrewMemberDoctor = require 'entities/crewmemberdoctor'
local CrewMemberSecurity = require 'entities/crewmembersecurity'
local CrewMemberPilot = require 'entities/crewmemberpilot'
local Siren = require 'entities/siren'
local LevelProgression = require 'entities/levelprogression'

local Level = Class{}
function Level:init()
end

-- Don't be tempted! Until Dec 12th
Global = {
    currentGame = nil,
    isGameOver = false,
    isGameWon = false,
    timeSinceOverlayOpened = 0, -- hack for overlay
    isCutscene = false,
    currentLevel = 1, -- todo: change to 1 when we ship
    currentLevelDefinition = nil,
    levelDefinitions = require 'levelDefinitions',
    -- debug stuff
    isDebug = true,
    isGodMode = false,
}
Global.currentLevelDefinition = Global.levelDefinitions[Global.currentLevel]

local text = Text('Hello Commander.', 100000);

Signal.register('write', function(s, speed)
    text:write(s, speed)
end)

Signal.register('writeMore', function(s, speed)
    text:writeMore(s, speed)
end)

local music = Music()

Signal.register('tranistionMusic', function (theme, time, volume)
    music:transition(theme, time, volume)
end)
-- example increase intensity
-- Signal.emit('tranistionMusic', 'intense', 5, .9)


function Level:load()
    -- ordering of systems really matters
    world = tiny.world(
        require ("systems/musicsystem")(),
        require ("systems/levelprogressionsystem")(), -- not a real system. let this run first tho
        require ("systems/misslowcommand/playercontrolsystem")(),
        require ("systems/plumbing/playercontrolsystem")(),
        require ("systems/navpanelcontrolsystem")(),
        require ("systems/gamehitboxsystem")(),
        require ("systems/misslowcommand/restartsystem")(),
        require ("systems/misslowcommand/motionsystem")(),
        require ("systems/misslowcommand/collisionsystem")(),
        require ("systems/ventgascontrolsystem")(),
        require ("systems/spinner/spinnersystem")(),
        require ("systems/plumbing/plumbingsystem")(),
        require ("systems/crewmemberanimationsystem")(),
        require ("systems/sirenanimationsystem")(),
        require ("systems/overlayInputSystem")(),

        -- draw systems

        require ("systems/drawsystems/spritesystem")(),
        require ("systems/drawsystems/textsystem")(),

        require ("systems/drawsystems/debughitboxsystem")(),
        require ("systems/drawsystems/drawnavpanelsystem")(),

        require ("systems/drawsystems/spinnerdrawsystem")(),
        require ("systems/drawsystems/plumbingsystem")(),
        require ("systems/drawsystems/drawventgassystem")(),
        require ("systems/drawsystems/misslowspritesystem")(),
        require ("systems/drawsystems/panelsystem")(),

        require ("systems/overlaySystem")(),

        -- let this go last
        require ("systems/drawsystems/drawdebuginfosystem")()
    )

    local screenWidth = love.graphics.getWidth()
    world:addEntity(Environment()) -- background layer, goes first
    world:addEntity(music)
    world:addEntity(LevelProgression())
    world:addEntity(Overlay())
    world:addEntity(text)

    world:addEntity(CrewMemberEngineer())
    world:addEntity(CrewMemberDoctor())
    world:addEntity(CrewMemberSecurity())
    world:addEntity(CrewMemberPilot())
    local sirenSideXOffset = 15
    local sirenMidsideXOffset = 50
    world:addEntity(Siren('sirens_side', sirenSideXOffset, 200, false))
    world:addEntity(Siren('sirens_side', screenWidth - sirenSideXOffset, 200, true))
    world:addEntity(Siren('sirens_midside', sirenMidsideXOffset, 90, false))
    world:addEntity(Siren('sirens_midside', screenWidth - sirenMidsideXOffset, 90, true))
    world:addEntity(Panel({x = 10, y = 300, w = 100, h = 250}, "plumbing"))
    world:addEntity(Panel({x = 80, y = 160, w = 160, h = 220}, "ventgas"))
    world:addEntity(Panel({x = 560, y = 160, w = 160, h = 220}, "spinner"))
    world:addEntity(Panel({x = 690, y = 300, w = 100, h = 250}, "misslowcommand"))

    world:addEntity(NavPanel())
    world:addEntity(VentGas())

    if Global.isDebug then
        world:addEntity(DebugInfo())
    end

    -- todo
    require 'signalhandlers'

    Signal.emit('startLevel', Global.currentLevel)
end

return Level
