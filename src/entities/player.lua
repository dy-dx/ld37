-- http://hump.readthedocs.io/en/latest/class.html
local anim8 = require '../vendor/anim8'
local assets = require 'src.assets'
local Player = Class{}

function Player:init()
    self.sprite = assets.img_megaman
    self.debugHitbox = true
    self.debugHitboxColor = { r = 0, g = 255, b = 0, a = 100 }
    self.controllable = true

    -- just guessing here
    self.hitbox = {x = 10, y = 10, w = 30, h = 30}
    self.isAlive = true
    self.isSolid = true

    self.facingRight = true
    self.pos = {x = 100, y = 500}
    self.vel = {x = 0, y = 0}
    self.xSpeed = 200
    self.jumpVelocity = -200
    self.gravity = 1000

    self.maxJumpTime = 0.3
    self.canJump = true
    self.jumpTime = 0

    self.timeBetweenShots = 0.1
    self.canShoot = true
    self.timeSinceShot = 1

    local g = anim8.newGrid(50, 50, assets.img_megaman:getWidth(), assets.img_megaman:getHeight())
    self.animationStand = anim8.newAnimation(g('1-1', 1), 0.1)
    self.animationShoot = anim8.newAnimation(g(3, 2), 0.1)
    self.animationWalk = anim8.newAnimation(g('4-6', 1), 0.1)
    self.animationWalkShoot = anim8.newAnimation(g('4-6', 2), 0.1)
    self.animationJump = anim8.newAnimation(g(7, 1), 0.1)
    self.animationJumpShoot = anim8.newAnimation(g(7, 2), 0.1)
    self.animation = self.animationStand
end

function Player:draw()
end

return Player
