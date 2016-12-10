ProjectilePhysicsSystem = tiny.processingSystem(Class{})

function ProjectilePhysicsSystem:init()
    self.filter = tiny.requireAll('hasProjectilePhysics')
end

function ProjectilePhysicsSystem:preProcess(dt)
end

function ProjectilePhysicsSystem:postProcess(dt)
end

function ProjectilePhysicsSystem:process(e, dt)
    e.pos.x = e.pos.x + e.vel.x * dt
    e.pos.y = e.pos.y + e.vel.y * dt
    if e.pos.x > 800 or e.pos.x < 0 then
        world:remove(e)
    end
end

return ProjectilePhysicsSystem
