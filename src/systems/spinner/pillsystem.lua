PillSystem = tiny.processingSystem(Class{})

function PillSystem:init()
    self.filter = tiny.requireAll('spinner', 'isPill')
end

function PillSystem:preProcess(dt)

end

function PillSystem:postProcess(dt)
end

function PillSystem:suicidePosition(e)
    return e.endX + 100;
end

function PillSystem:lastPosition(e)
    if e.isSuicidal then
        return self:suicidePosition(e);
    else
        return e.endX - (e.queue - 1) * (e.pos.w + e.padding)
    end
end

function PillSystem:velocity(e)
    if e.isSuicidal then
        return e.velocity + 1000;
    else
        return e.velocity
    end
end

function PillSystem:process(e, dt)

    if(e.pos.x == self:suicidePosition(e)) then
        world:removeEntity(e)
    end

    local nextPos = self:velocity(e) * dt + e.pos.x;
    local theLastPosition = self:lastPosition(e)
    if(nextPos > theLastPosition) then
        nextPos = theLastPosition
    end

    e.pos.x = nextPos
end

return PillSystem
