local bump = require('vendor/bump')
local Panel = require 'entities/panel'

local Level = Class{}
function Level:init()
end

function Level:load()
    world = tiny.world(
        require ("systems/playercontrolsystem")(),
        require ("systems/spritesystem")(),
        require ("systems/panelsystem")(),
        require ("systems/debughitboxsystem")()
    )

    local panel = Panel()

    world:addEntity(panel)

end

return Level
