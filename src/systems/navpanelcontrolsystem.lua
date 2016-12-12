NavPanelControlSystem = tiny.processingSystem(Class{})

function NavPanelControlSystem:init()
    self.filter = tiny.requireAll('isNavPanel')
    self.input = Input()
    self.input:bind('mouse1', 'left_click')
end

function NavPanelControlSystem:preProcess(dt)
end

function NavPanelControlSystem:postProcess(dt)
end

function NavPanelControlSystem:process(e, dt)
    if not lume.any(Global.currentLevelDefinition.activeGames, function(x) return x == 'nav' end) then
        return
    end

    local cursorOverLeftButton = false
    local cursorOverRightButton = false
    local leftClicked = false
    local rightClicked = false

    if self.input:down('left_click') then
        local x, y = love.mouse.getPosition()
        if x >= e.leftButton.x and x <= e.leftButton.x + e.leftButton.w and y >= e.leftButton.y and y <= e.leftButton.y + e.leftButton.h then
            cursorOverLeftButton = true
        elseif x >= e.rightButton.x and x <= e.rightButton.x + e.rightButton.w and y >= e.rightButton.y and y <= e.rightButton.y + e.rightButton.h then
            cursorOverRightButton = true
        end
    end

    -- up/down states for visual feedback
    e.leftButtonDown = false
    e.rightButtonDown = false
    if self.input:down('left_click') then
        e.leftButtonDown = cursorOverLeftButton
        e.rightButtonDown = cursorOverRightButton
    end

    if self.input:pressed('left_click') then
        leftClicked = cursorOverLeftButton
        rightClicked = cursorOverRightButton
    end

    -- rotate the ship via user input
    local rotationStep = 0.1
    if leftClicked then
        e.rotation = e.rotation - rotationStep
    elseif rightClicked then
        e.rotation = e.rotation + rotationStep
    end

    local maxRotation = 1
    local minRotation = 0.03
    local fuckeryRate = Global.currentLevelDefinition.nav.fuckeryRate
    if e.rotation == 0 then
        -- start the fuckery
        e.rotation = (love.math.random() - 0.5) * 0.05
        if e.rotation > 0 then
            e.rotation = math.max(e.rotation, minRotation)
        elseif e.rotation < 0 then
            e.rotation = math.min(e.rotation, -minRotation)
        end
    end

    e.rotation = e.rotation + e.rotation * fuckeryRate * dt
    e.rotation = lume.clamp(e.rotation, -maxRotation, maxRotation)

    e.secondsSinceDeparture = e.secondsSinceDeparture + dt
    e.shipYOffset = e.shipYOffset + dt * e.rotation * 10 -- arbitrary magic number but it works
    -- e.shipYOffset = lume.clamp(e.shipYOffset, -40, 40) -- temp -- just some huge number so it doesnt get drawn in the middle of nowhere

    if math.abs(e.shipYOffset) > e.lcdpos.h/2 then
        Signal.emit('gameover', 'nav')
    end
    if e.shipTipX ~= nil and e.shipTipY ~= nil then
        if (e.shipTipX - (e.lcdpos.x + e.lcdpos.w))^2 + (e.shipTipY - (e.lcdpos.y + e.lcdpos.h/2))^2 < e.planetRadius^2 then
            Global.currentLevel = Global.currentLevel + 1
            -- fixme
            Global.currentLevelDefinition = Global.levelDefinitions[Global.currentLevel]
            Signal.emit('startLevel', Global.currentLevel)
        end
    end

    -- todo: should do this in levelprogressionsystem
    --if e.secondsSinceDeparture >= Global.currentLevelDefinition.duration then
    --    Global.currentLevel = Global.currentLevel + 1
    --    -- fixme
    --    Global.currentLevelDefinition = Global.levelDefinitions[Global.currentLevel]
    --    Signal.emit('startLevel', Global.currentLevel)
    --end
end

return NavPanelControlSystem
