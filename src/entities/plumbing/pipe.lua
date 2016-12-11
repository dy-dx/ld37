local CurvedPipe = Class{}

local SIZE = 50
local FLUID_RATE = 0.1

local offsett = {
    x = 125,
    y = 125
}

function CurvedPipe:init(x, y, rotation)
    self.plumbing = true
    self.pos = {
        x = x * SIZE + offsett.x,
        y = y * SIZE + offsett.y
    }
    self.rotation = rotation  -- this is for the game logic stuff, [0, 3]
    self.rot = rotation * math.pi / 2  -- this is for the display stuff, [0, 2π)
    self.sprite = love.graphics.newImage('assets/images/pipeLD.png')
    self.offset = {
        x = self.sprite:getWidth() / 2,
        y = self.sprite:getHeight() / 2
    }
    self.leftToDown = true
    self.isDead = false
    self.fluidProgress = 0
end

function CurvedPipe:predraw(dt)
    -- No fluid
    if self.fluidProgress == 0 then return end

    love.graphics.setColor(0, 0xFF, 0, 0xFF)
    -- All fluid
    if self.fluidProgress == 1 then
        love.graphics.polygon(
            'fill',
            self.pos.x - SIZE / 2, self.pos.y - SIZE / 2,
            self.pos.x + SIZE / 2, self.pos.y - SIZE / 2,
            self.pos.x + SIZE / 2, self.pos.y + SIZE / 2,
            self.pos.x - SIZE / 2, self.pos.y + SIZE / 2
        )
    -- Some fluid
    else
        -- originally, vertices refers to a down-to-left bend
        local vertices = {
            {x = SIZE / 2, y = SIZE / 2},  -- bottom right
            {x = -SIZE / 2, y = SIZE / 2},  -- bottom left
            -- bottom right to top left
            {x = SIZE / 2 - self.fluidProgress * SIZE, y = SIZE / 2 - self.fluidProgress * SIZE}
        }
        local flattenedVertices = {}
        for k, coord in ipairs(vertices) do
            local x, y = coord.x, coord.y

            -- Flip depending on which side of the pipe the fluid enters
            if self.leftToDown then
                x, y = -y, -x
            end

            -- Rotate depending on the rotation of the pipe
            if self.rotation == 1 then
                y, x = x, -y
            elseif self.rotation == 2 then
                x, y = -x, -y
            elseif self.rotation == 3 then
                y, x = -x, y
            end

            -- `polygon` wants a flattened array-table for some reason ᖍ(ツ)ᖌ
            table.insert(flattenedVertices, x + self.pos.x)
            table.insert(flattenedVertices, y + self.pos.y)
        end
        love.graphics.polygon('fill', flattenedVertices)
    end
    love.graphics.setColor(0xFF, 0xFF, 0xFF, 0xFF)
end

function CurvedPipe:process(dt)
    self.fluidProgress = math.min(self.fluidProgress + dt * FLUID_RATE, 1)
end

return CurvedPipe
