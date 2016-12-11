local Utils = require('utils')

local CurvedPipe = require 'entities/plumbing/curvedpipe'
local StraightPipe = require 'entities/plumbing/straightpipe'

PlayerControlSystem = tiny.processingSystem(Class{})

local OFFSET_X = 125
local OFFSET_Y = 125


function newPipe(isStraight, x, y, rotation)
    if isStraight then
        return StraightPipe(x, y, OFFSET_X, OFFSET_Y, rotation)
    else
        return CurvedPipe(x, y, OFFSET_X, OFFSET_Y, rotation)
    end
end

function PlayerControlSystem:pipeAtMouse()
    local x, y = love.mouse.getPosition()
    x = math.floor((x - 100) / 50)
    y = math.floor((y - 100) / 50)
    local key = getPipeKey(x, y)
    return Global.pipes[key]
end

function getPipeKey(x, y)
    return x .. '_' .. y
end

function PlayerControlSystem:init()
    self.name = "plumbing"
    self.filter = tiny.requireAll('controllable')
    self.input = Input()
    self.input:bind('mouse1', 'mouse1')
end

function PlayerControlSystem:preProcess(dt)
end

function PlayerControlSystem:postProcess(dt)
end

function PlayerControlSystem:process(e, dt)
    if Global.currentGame ~= self.name or e.gName ~= self.name then
        return
    end

    -- RELEASE
    if self.input:released("mouse1") and self.liftedPipe then
        local swapPipe = self:pipeAtMouse()
        if swapPipe and swapPipe ~= self.liftedPipe and swapPipe:canMove() then
            -- swap em
            world:remove(swapPipe)
            world:remove(self.liftedPipe)
            world:addEntity(newPipe(
                swapPipe.isStraight,
                self.liftedPipe.pipeCoordinate.x, self.liftedPipe.pipeCoordinate.y,
                swapPipe.rotation
            ))
            world:addEntity(newPipe(
                self.liftedPipe.isStraight,
                swapPipe.pipeCoordinate.x, swapPipe.pipeCoordinate.y,
                self.liftedPipe.rotation
            ))
        else
            -- put it back
            self.liftedPipe.pos = self.liftedPipe.normalPos
        end
        -- put it down
        self.liftedPipe.lifted = false
        self.liftedPipe = nil
    end

    -- PRESS
    if self.input:pressed("mouse1") then
        local x, y = love.mouse.getPosition()

        local pipe = self:pipeAtMouse()
        if pipe and pipe:canMove() then
            -- we create a new one to update the draw order, so it'll be on top
            -- gross!
            pipe = newPipe(
                pipe.isStraight,
                pipe.pipeCoordinate.x, pipe.pipeCoordinate.y,
                pipe.rotation
            )
            pipe.lifted = true
            world:addEntity(pipe)
            self.liftedPipe = pipe
        elseif Utils.isInCircle(x - 628, y - 375, 18) then
            -- Refresh scrap
            world:addEntity(randomPipe(11, 5))
        end
    end

    -- DRAG
    if self.liftedPipe then
        local x, y = love.mouse.getPosition()
        self.liftedPipe.pos = {x=x, y=y}
    end
end

return PlayerControlSystem
