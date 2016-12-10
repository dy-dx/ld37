local CollisionBox = Class{}

function CollisionBox:init(x, y, w, h)
    self.debugHitbox = false
    self.debugHitboxColor = { r = 0, g = 0, b = 255, a = 100 }
    self.hitbox = {x = 0, y = 0, w = w or 100, h = h or 100}

    self.isAlive = true
    self.isSolid = true
    self.isStatic = true
    self.pos = {x = x, y = y}
    self.vel = {x = 0, y = 0}
end

return CollisionBox
