-- http://hump.readthedocs.io/en/latest/class.html
local Bullet = Class{}

function Bullet:init(x, y, movingRight)
    self.sprite = love.graphics.newImage("assets/images/bullet.png")

    self.debugHitbox = false
    self.debugHitboxColor = { r = 0, g = 255, b = 0, a = 100 }

    -- 15 x 15 center of image
    self.hitbox = {x = 10, y = 10, w = 15, h = 15}

    self.isDead = false
    self.isSolid = false
    self.hasProjectilePhysics = true
    self.isBullet = true

    self.pos = {x = x, y = y}
    self.vel = {x = 0, y = 0}

    if movingRight then
        self.vel.x = 500
    else
        self.vel.x = -500
    end
end

return Bullet
