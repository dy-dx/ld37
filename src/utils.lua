local Utils = Class{}

function Utils.isInside(point, hitbox)
    return hitbox.x < point.x and
        point.x < hitbox.x + hitbox.w and
        hitbox.y < point.y and
        point.y < hitbox.y + hitbox.h;
end

function Utils.printFilled(area, color)
    love.graphics.setColor(color.r, color.g, color.b, color.a)
    love.graphics.rectangle('fill', area.x, area.y, area.w, area.h)
    love.graphics.setColor(255, 255, 255)
end

return Utils
