-- http://hump.readthedocs.io/en/latest/class.html
local DrawLayer = Class{}

function DrawLayer:init(tileMap)
    self.isDrawLayer = true
    self.tileMap = tileMap
end

function DrawLayer:draw(dt)
    self.tileMap:draw()
end

return DrawLayer
