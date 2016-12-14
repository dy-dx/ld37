local CutsceneDrawSystem = Class{}
CutsceneDrawSystem = tiny.processingSystem(CutsceneDrawSystem)

function CutsceneDrawSystem:init()
    self.isDrawingSystem = true
    self.filter = tiny.requireAll('isCutscene')
    self.particleSprite = love.graphics.newImage("assets/images/2x2whitesquare.png")
    local ps = love.graphics.newParticleSystem( self.particleSprite, 3000 )
    self.ps = ps
    ps:setParticleLifetime(10, 10) -- Particles live at least 10s and at most 10s.
    ps:setSpeed(-1200, -100)
    ps:setEmissionRate(32)
    -- ps:setLinearAcceleration(-50, -1, -30, 1)
    ps:setAreaSpread( 'uniform', 0, love.graphics.getHeight() * 0.5 )
end

function CutsceneDrawSystem:preProcess(dt)
end

function CutsceneDrawSystem:postProcess(dt)
    love.graphics.setColor(255, 255, 255, 255)
end

local getCurrentDialogue = function(e)
    -- print(e.cutsceneType)
    if e.cutsceneType == 'intro' then
        return Global.currentLevelDefinition.cutsceneDialogue[e.currentDialogueIndex]
    else
        return e.gameOverText
    end
end

function CutsceneDrawSystem:process(e, dt)
    if not Global.isCutscene then return end
    e.timer:update(dt)

    -- draw space
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', 0, 0, 800, 600)
    love.graphics.setColor(255, 255, 255, 255)

    -- draw ship
    -- local sPos = {
    --     x = 340,
    --     y = 360
    -- }
    -- love.graphics.polygon('fill',
    --     sPos.x, sPos.y - 15,
    --     sPos.x, sPos.y + 15,
    --     sPos.x + 30, sPos.y
    -- )

    self.ps:update(dt)
    love.graphics.draw(self.ps, love.graphics.getWidth(), love.graphics.getHeight() * 0.5)

    -- draw dialogue
    local line = getCurrentDialogue(e)
    local x = 200
    local y = 200
    local font = e.dialogueFont
    if not e.drawRestOfText then
        e.time = e.time + dt
        e.currentCharacter = math.floor((e.time * e.speed) / 1000)
        local newTextWidth, wrappedText = font:getWrap(line, e.maxTextWidth)
        local toPrint = {}
        local ncharCounter = 0
        for row, l in ipairs(wrappedText) do
            local tmp_table = {}
            for i = 1, #l do
                local c = l:sub(i,i)
                if ncharCounter < e.currentCharacter then
                    table.insert(tmp_table, c)
                else
                    break
                end
                ncharCounter = ncharCounter + 1
            end
            table.insert(toPrint, tmp_table)
        end
        local i = 1
        lume.map(toPrint, function(l)
            local currentFont = love.graphics.newText(font, l)
            love.graphics.draw(currentFont, x, y + i * currentFont:getHeight())
            i = i + 1
        end)
        e.currentCharacter = e.currentCharacter + 1
    else
        local newTextWidth, wrappedText = font:getWrap(line, e.maxTextWidth)
        local i = 1
        lume.map(wrappedText, function(l)
            local currentFont = love.graphics.newText(font, l)
            love.graphics.draw(currentFont, x, y + i * currentFont:getHeight())
            i = i + 1
        end)
    end
end

return CutsceneDrawSystem
