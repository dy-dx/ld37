local Utils = Class{}

function Utils.isInside(point, hitbox)
    return hitbox.x < point.x and
        point.x < hitbox.x + hitbox.w and
        hitbox.y < point.y and
        point.y < hitbox.y + hitbox.h;
end

function Utils.mode(mode)
    if(not mode) then return 'fill' else return mode end
end

function Utils.printFilled(area, color, mode)
    love.graphics.setColor(color.r, color.g, color.b, color.a)
    love.graphics.rectangle(Utils.mode(mode), area.x, area.y, area.w, area.h)
    love.graphics.setColor(255, 255, 255)
end

function Utils.isInCircle(x, y, radius)
    return x * x + y * y < radius * radius
end

function Utils.split(textString, sep)
    words = {}
    for w in textString:gmatch(sep) do table.insert(words, w) end
    return words
end

function Utils.pickRandom(arr)
    return arr[math.random(table.getn(arr))]
end

return Utils
