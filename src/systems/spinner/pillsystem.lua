PillSystem = tiny.processingSystem(Class{})

function PillSystem:init()
    self.filter = tiny.requireAll('spinner', 'isPill')
end

function PillSystem:preProcess(dt)

end

function PillSystem:postProcess(dt)
end

function PillSystem:process(e, dt)
    local nextPos = e.velocity * dt + e.pos.x;
    local theLastPosition = e.endX - (e.queue - 1) * (e.pos.w + e.padding)
    if(nextPos > theLastPosition) then
        nextPos = theLastPosition
    end

    e.pos.x = nextPos
end

return PillSystem
