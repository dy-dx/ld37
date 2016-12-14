local Utils = require 'utils'

local Missile = require 'entities/misslowcommand/missile'

MisslowCommandSystem = tiny.processingSystem(Class{})

-- local TIME_TO_MISSILE = 8  -- seconds

local MISSILE_LENGTH = 35
local WIDTH = 720
local HEIGHT = 480
local OFFSET = 40


-- function restartLevel()
--     -- TODO: cleanup

--     math.randomseed(os.time())
--     self.cooldown = 0

--     world:addEntity(Background())
--     world:addEntity(Ship())
-- end

-- Signal.register('startLevel', restartLevel)

function MisslowCommandSystem:init()
    self.filter = tiny.requireAll('pos', 'velocity', 'process', 'isDead', 'misslowcommand')
    self.cooldown = 0
end

function MisslowCommandSystem:preProcess(dt)
    if not Utils.isAnActiveGame('misslowcommand') then
        return
    end

    local timeToMissile = 8  -- seconds, default
    if Global.currentLevelDefinition.misslowcommand then
        timeToMissile = Global.currentLevelDefinition.misslowcommand.timeToMissile
    end

    self.cooldown = self.cooldown - dt
    if self.cooldown <= 0 then
        self.cooldown = timeToMissile

        local wall = math.floor(math.random() * 4)
        local x, y

        if wall < 2 then
            x = math.random() * (WIDTH - MISSILE_LENGTH) + OFFSET + MISSILE_LENGTH / 2
            y = wall * (HEIGHT - MISSILE_LENGTH) + OFFSET + MISSILE_LENGTH / 2
        else
            x = (wall - 2) * (WIDTH - MISSILE_LENGTH) + OFFSET + MISSILE_LENGTH / 2
            y = math.random() * (HEIGHT - MISSILE_LENGTH) + OFFSET + MISSILE_LENGTH / 2
        end

        -- Signal.emit('writeMore', "Warning: new missile", 100000)
        world:add(Missile(
            x, y,
            400, 300
        ))
    end
end

function MisslowCommandSystem:postProcess(dt)
    if not Utils.isAnActiveGame('misslowcommand') then
        return
    end

    -- if you saw a missile on this tick
    if self.sawAMissile then
        self.sawAMissile = false
        Signal.emit('dangerLevel', 'misslowcommand', 3)
    else
        Signal.emit('dangerLevel', 'misslowcommand', 1)
    end
end

function MisslowCommandSystem:process(e, dt)
    if not Utils.isAnActiveGame('misslowcommand') then
        return
    end

    if e.isMissile then
        self.sawAMissile = true
    end

    e.pos.x = e.velocity.x * dt + e.pos.x
    e.pos.y = e.velocity.y * dt + e.pos.y

    e:process(dt)
    if e.isDead then
        world:remove(e)
    end
end

return MisslowCommandSystem
