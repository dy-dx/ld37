local PreEnvFX = Class{}
PreEnvFX = tiny.processingSystem(PreEnvFX)

function PreEnvFX:init()
    self.isDrawingSystem = true
    self.filter = tiny.requireAll('isEnvironment', 'isBackground')
end

function PreEnvFX:preProcess(dt)
end

function PreEnvFX:postProcess(dt)
    -- love.graphics.setColor(255, 255, 255, alpha)
end

function PreEnvFX:process(e, dt)
    local an = e.animation
    local alpha = e.alpha or 1
    local pos, sprite, scale, rot, offset = e.pos, e.sprite, e.scale, e.rot, e.offset
    local sx, sy, r, ox, oy = scale and scale.x or 1, scale and scale.y or 1, rot or 0, offset and offset.x or 0, offset and offset.y or 0
    if e.flipVertically then
        sy = -1*sy
    end
    if e.flipHorizontally then
        sx = -1*sx
    end

    -- love.graphics.setColor(255, 255, 255, math.max(0, math.min(1, alpha)) * 255)

    local maxLevel = 1
    local bgr = 255
    local bgg = 255
    local bgb = 255
    for game, level in pairs(e.dangerLevels) do
        if level > maxLevel then maxLevel = level end
    end
    if maxLevel >= 3 then
        bgr = 200
        bgg = 140
        bgb = 140
    elseif maxLevel == 2 then
        bgr = 255
        bgg = 230
        bgb = 220
    end
    love.graphics.setColor(bgr, bgg, bgb, 255)

    if an then
        an.flippedH = e.flippedH or false
        an.flippedV = e.flippedV or false
        an:update(dt)
        an:draw(sprite, pos.x, pos.y, r, sx, sy, ox, oy)
    else
        love.graphics.draw(sprite, pos.x, pos.y, r, sx, sy, ox, oy)
    end

    if e.draw then
        e:draw(dt)
    end
end

return PreEnvFX
