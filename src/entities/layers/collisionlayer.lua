local layerUtils = require 'utils/layerutils'

local CollisionLayer = Class{}

function CollisionLayer:init(tileMap, bumpWorld)
    for lindex, layer in ipairs(tileMap.layers) do
        if layer.name == 'CollisionLayer' then
            local prefix = layer.properties.oneway == "true" and "o(" or "t("
            for y, tiles in ipairs(layer.data) do
                for x, tile in pairs(tiles) do
                    bumpWorld:add(
                        prefix..layer.name..", "..x..", "..y..")",
                        (x - 1) * tileMap.tilewidth + tile.offset.x,
                        (y - 1) * tileMap.tileheight + tile.offset.y,
                        tile.width,
                        tile.height
                    )
                end
            end
        end
    end
end

return CollisionLayer
