MisslowCommandSystem = tiny.processingSystem(Class{})

function MisslowCommandSystem:init()
    self.filter = tiny.requireAll('pos', 'velocity', 'destination', 'misslowcommand')
end

function MisslowCommandSystem:preProcess(dt)
end

function MisslowCommandSystem:postProcess(dt)
end

function MisslowCommandSystem:process(e, dt)
    e.pos.x = e.velocity.x + e.pos.x
    e.pos.y = e.velocity.y + e.pos.y

    local ox = e.pos.x - e.destination.x
    local oy = e.pos.y - e.destination.y
    if ox * ox + oy * oy < e.SPEED * e.SPEED then
        print "BOOM"
        world:remove(e)
    end
    -- e:process(dt)
end

return MisslowCommandSystem
