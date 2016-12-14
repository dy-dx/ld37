local DrawDebugInfoSystem = Class{}
DrawDebugInfoSystem = tiny.processingSystem(DrawDebugInfoSystem)

function DrawDebugInfoSystem:init()
    self.isDrawingSystem = true
    self.isCutsceneSystem = true
    self.filter = tiny.requireAll('isDebugInfo')
end

function DrawDebugInfoSystem:preProcess(dt)
    love.graphics.setColor(255, 255, 255, 255)
end

function DrawDebugInfoSystem:postProcess(dt)
    love.graphics.setColor(255, 255, 255, 255)
end

function DrawDebugInfoSystem:process(e, dt)
    local lineHeight = 14
    local lines = {
        "Entity Count: " .. world:getEntityCount(),
        "isGameOver: " .. tostring(Global.isGameOver),
        "isCutscene: " .. tostring(Global.isCutscene),
        "isGodMode: " .. tostring(Global.isGodMode),
        "currentLevel: " .. tostring(Global.currentLevel),
    }
    for name, level in pairs(e.dangerLevels) do
        local text = nil
        if level == 1 then
            text = 'ok'
        elseif level == 2 then
            text = 'WARNING'
        elseif level == 3 then
            text = 'EXTREME DANGER!!!!!!!!'
        end
        if text then
            lume.push(lines, name .. ": " .. text)
        end
    end
    for i, line in ipairs(lines) do
        love.graphics.print(line, 2, lineHeight * (i-1))
    end
end

return DrawDebugInfoSystem
