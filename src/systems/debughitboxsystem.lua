local DebugHitboxSystem = Class{}
DebugHitboxSystem = tiny.processingSystem(DebugHitboxSystem)

function DebugHitboxSystem:init()
    self.isDrawingSystem = true
    self.filter = tiny.requireAll('debugHitbox', 'pos', 'hitbox')
    self.defaultColor = { r = 255, g = 105, b = 180, a = 100 }
end

function DebugHitboxSystem:preProcess(dt)
    -- love.graphics.setColor(255, 105, 180, 100)
end

function DebugHitboxSystem:postProcess(dt)
    love.graphics.setColor(255, 255, 255, 255)
end

function DebugHitboxSystem:process(e, dt)
    if e.debugHitbox then
        local pos = e.pos
        local hitbox = e.hitbox
        local c = self.defaultColor
        if e.debugHitboxColor then
            c = e.debugHitboxColor
        end
        love.graphics.setColor(c.r, c.g, c.b, c.a)
        love.graphics.rectangle('fill', pos.x + hitbox.x, pos.y + hitbox.y, hitbox.w, hitbox.h)
    end
end

return DebugHitboxSystem
