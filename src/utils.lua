local Utils = Class{}

function Utils.isInside(point, hitbox)
    return hitbox.x < point.x and
        point.x < hitbox.x + hitbox.w and
        hitbox.y < point.y and
        point.y < hitbox.y + hitbox.h;
end

return Utils
