-- globals
lume = require '../vendor/lume'
Class = require '../vendor/hump.class'
Input = require '../vendor/input'
Timer = require '../vendor/hump.timer'
Signal = require '../vendor/hump.signal'
tiny = require '../vendor/tiny'
require 'sounds'

function printTable(mytable)
    for k, v in pairs(mytable) do
       print(k, v)
    end
end

local level = require('states/level0')()
-- local level = require('states/levelmisslowcommand')()
-- local level = require('states/ventgaslevel')()
-- local level = require('states/gameoverscene')()

function love.load()
    level:load()
end

local drawSystems = function(_, s) return not not s.isDrawingSystem end
local updateSystems = function(_, s) return not s.isDrawingSystem end

function love.draw()
    if world then
        world:update(love.timer.getDelta(), drawSystems)
    end
end


function love.update(dt)
    Timer.update(dt)
    if world then
        world:update(love.timer.getDelta(), updateSystems)
        -- print (world:getEntityCount())
    end
end
