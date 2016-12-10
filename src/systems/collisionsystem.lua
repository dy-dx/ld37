CollisionSystem = tiny.processingSystem(Class{})

function CollisionSystem:init()
    self.explosions = {}
    self.filter = tiny.requireAll("isCollidable")
end

function CollisionSystem:preProcess(dt)
end

function CollisionSystem:postProcess(dt)
end

function CollisionSystem:process(e, dt)
    if e.isMissile then
        local ox, oy
        for explosion, _ in pairs(self.explosions) do
            ox = e.pos.x - explosion.pos.x
            oy = e.pos.y - explosion.pos.y
            if ox * ox + oy * oy < 50 * 50 then
                e.isDead = true
            end
        end
    end
end

function CollisionSystem:onAdd(e)
    if e.isExplosion then
        self.explosions[e] = e
    end
end

function CollisionSystem:onRemove(e)
    self.explosions[e] = nil
end

return CollisionSystem
