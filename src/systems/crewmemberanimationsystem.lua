local Timer = require 'vendor/hump.timer'
CrewMemberAnimationSystem = tiny.processingSystem(Class{})

function CrewMemberAnimationSystem:init()
    self.filter = tiny.requireAll('isCrewMemberAnimationSystem')
end

function CrewMemberAnimationSystem:preProcess(dt)

end

function CrewMemberAnimationSystem:postProcess(dt)

end

local function switchAnimation(e)
    if e.isBobbing then
        e.isBobbing = false
        e.sprite = e.pressButtonSheet
        e.animation = e.animationButtonPress
        e.animation:gotoFrame(1)
    else
        e.isBobbing = true
        e.sprite = e.bobbingSheet
        e.animation = e.animationBob
    end
end

function CrewMemberAnimationSystem:process(e, dt)
    e.timerButtonPressProbCheck:update(dt)
    e.timerButtonPressDuration:update(dt)
end

function CrewMemberAnimationSystem:onAdd(e)
    e.timerButtonPressProbCheck = Timer.new()
    e.timerButtonPressDuration = Timer.new()
    e.timerButtonPressProbCheck:every(1, function()
        local randomNumber = math.random(1, 100)
        if e.isBobbing and randomNumber <= 20 then
            switchAnimation(e)
            e.timerButtonPressDuration:after(e.nframes*e.buttonPressAnimationRate, function() switchAnimation(e) end)
        end
    end)
end

return CrewMemberAnimationSystem
