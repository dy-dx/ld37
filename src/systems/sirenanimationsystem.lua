SirenAnimationSystem = tiny.processingSystem(Class{})

function SirenAnimationSystem:init()
    self.filter = tiny.requireAll("isSirenAnimationSystem")
end

function SirenAnimationSystem:preProcess(dt)

end

function SirenAnimationSystem:postProcess(dt)

end

local function toggleAnimation(e)
    if e.isAnimated then
        e.isAnimated = false
        e.sprite = e.sirenOffImage
        e.animation = nil
    else
        e.isAnimated = true
        e.sprite = e.sirenOnSheet
        e.animation = e.animationSirenOn
    end
end
function SirenAnimationSystem:process(e, dt)
    if not e.isAnimated and e.dangerLevel == 3 then
        toggleAnimation(e)
    elseif e.isAnimated and (e.dangerLevel == 2 or e.dangerLevel == 1) then
        toggleAnimation(e)
    end
end

return SirenAnimationSystem
