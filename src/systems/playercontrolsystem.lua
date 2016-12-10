local Bullet = require 'entities/bullet'

PlayerControlSystem = tiny.processingSystem(Class{})

function PlayerControlSystem:init()
    self.filter = tiny.requireAll('controllable')
    self.input = Input()
    self.input:bind('left', 'left')
    self.input:bind('right', 'right')
    self.input:bind('up', 'up')
    self.input:bind('z', 'z')
end

function PlayerControlSystem:preProcess(dt)
end

function PlayerControlSystem:postProcess(dt)
end

function PlayerControlSystem:process(e, dt)
    -- update cool down timers and toggle bools.
    if not e.canShoot then
        e.timeSinceShot = e.timeSinceShot + dt
        if e.timeSinceShot >= e.timeBetweenShots then
            e.canShoot = true
        end
    end

    if (e.grounded) then
        e.jumpTime = 0
        e.canJump = true
    end

    if self.input:released("up") then
        e.canJump = false
    end
    if e.jumpTime >= e.maxJumpTime then
        e.canJump = false
    end

    -- change state based on input
    if self.input:down("up") and e.canJump then
        e.vel.y = e.jumpVelocity
        e.jumpTime = e.jumpTime + dt
    end

    if self.input:down("left") then
        e.vel.x = -e.xSpeed
        if not self.input:down("z") then
            e.facingRight = false
        end
    elseif self.input:down("right") then
        e.vel.x = e.xSpeed
        if not self.input:down("z") then
            e.facingRight = true
        end
    else
        e.vel.x = 0
    end

    if self.input:down("z") and e.canShoot then
        Signal.emit('meow')
        world:addEntity(Bullet(e.pos.x + 5, e.pos.y + 5, e.facingRight))
        e.timeSinceShot = 0
        e.canShoot = false
    end

    -- select animation
    -- shooting
    if self.input:down("z") then
        if not e.grounded then
            e.animation = e.animationJumpShoot
        elseif self.input:down("right") or self.input:down("left") then
            e.animation = e.animationWalkShoot
        else
            e.animation = e.animationShoot
        end
    -- non-shooting
    elseif not e.grounded then
        e.animation = e.animationJump
    elseif self.input:down("right") or self.input:down("left") then
        e.animation = e.animationWalk
    else
        e.animation = e.animationStand
    end

    -- anim8 uses flippedH by default, but that is kind of a crappy variable name, so we set it at the end
    e.flippedH = not e.facingRight
end

return PlayerControlSystem
