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

function Utils.has_value (tab, val)
    for index, value in ipairs (tab) do
        -- We grab the first index of our sub-table instead
        if value == val then
            return true
        end
    end

    return false
end

function Utils.isAnActiveGame (gamename)
    if not Global then return false end
    if Global.isCutscene then return false end
    return lume.any(Global.currentLevelDefinition.activeGames, function(x) return x == gamename end)
end

return Utils
