local DrawDebugInfoSystem = Class{}
DrawDebugInfoSystem = tiny.processingSystem(DrawDebugInfoSystem)

function DrawDebugInfoSystem:init()
    self.isDrawingSystem = true
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
        "isCutScene: " .. tostring(Global.isCutScene),
        "currentLevel: " .. tostring(Global.currentLevel),
    }
    for i, line in ipairs(lines) do
        love.graphics.print(line, 2, lineHeight * (i-1))
    end
end

return DrawDebugInfoSystem
