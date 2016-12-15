local SpinnerDrawSystem = Class{}
SpinnerDrawSystem = tiny.processingSystem(SpinnerDrawSystem)

function SpinnerDrawSystem:init()
    self.name = "spinner"
    self.isDrawingSystem = true
    self.filter = tiny.requireAll('pos', self.name)
end

function SpinnerDrawSystem:preProcess(dt)
    if Global.currentGame ~= self.name then return end
    love.graphics.setColor(14, 15, 15, 255)
    love.graphics.rectangle('fill', 90, 78, 622, 384)
end

function SpinnerDrawSystem:postProcess(dt)
    love.graphics.setColor(255, 255, 255, 255)
end

function SpinnerDrawSystem:drawButton(e)
    sprite = nil
    if(e.buttonCooldownTimer > 0) then
        sprite = e.buttonUpSprite
    else
        sprite = e.buttonDownSprite
    end

    love.graphics.draw(sprite, e.buttonCenter.x, e.buttonCenter.y,  r, sx, sy, sprite:getWidth() / 2, sprite:getHeight() / 2)
end

function SpinnerDrawSystem:process(e, dt)
    if Global.currentGame ~= self.name then return end

    if e.sprite then
        local an = e.animation
        local alpha = e.alpha or 1
        local pos, sprite, scale, rot, offset = e.pos, e.sprite, e.scale, e.rot, e.offset
        local sx, sy, r, ox, oy = scale and scale.x or 1, scale and scale.y or 1, rot or 0, offset and offset.x or 0, offset and offset.y or 0
        love.graphics.setColor(255, 255, 255, math.max(0, math.min(1, alpha)) * 255)
        if an then
            an.flippedH = e.flippedH or false
            an.flippedV = e.flippedV or false
            an:update(dt)
            an:draw(sprite, pos.x, pos.y, r, sx, sy, ox, oy)
        else
            love.graphics.draw(sprite, pos.x, pos.y, r, sx, sy, ox, oy)
        end
    end

    if e.buttonCenter then SpinnerDrawSystem:drawButton(e) end

    if e.draw then
        e:draw(dt)
    end
end

return SpinnerDrawSystem
