local LayerUtils = Class{}

function LayerUtils:init() end

-- Todo Make this do stuff
function LayerUtils:getLayerNames()
    for k, v in pairs(Globals.map) do
       print(k, v)
    end
end


function LayerUtils:getLayer(layerName)
    return Global.map.layers[layerName]
end


return LayerUtils
