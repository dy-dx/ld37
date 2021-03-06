local CurvedPipe = Class{}

local SIZE = 50

function rotateCoords(x, y, rotation)
    rotation = rotation % 4
    if rotation == 0 then
        return {x = x, y = y}
    elseif rotation == 1 then
        return {x = -y, y = x}
    elseif rotation == 2 then
        return {x = -x, y = -y}
    elseif rotation == 3 then
        return {x = y, y = -x}
    end
end

function CurvedPipe:init(x, y, offsetX, offsetY, rotation)
    self.plumbing = true
    self.isStraight = false
    self.lifted = false
    self.pipeCoordinate = {x = x, y = y}
    self.normalPos = {
        x = x * SIZE + offsetX,
        y = y * SIZE + offsetY
    }
    self.pos = self.normalPos
    self.rotation = rotation  -- this is for the game logic stuff, [0, 3]
    self.rot = rotation * math.pi / 2  -- this is for the display stuff, [0, 2π)
    self.sprite = love.graphics.newImage('assets/images/pipeLD.png')
    self.hilite = love.graphics.newImage('assets/images/highlight.png')
    self.highlighted = false
    self.offset = {
        x = self.sprite:getWidth() / 2,
        y = self.sprite:getHeight() / 2
    }
    self.clockwise = true
    self.isDead = false
    self.filling = false
    self.fluidProgress = 0
    -- default draw order
    self.drawId = x + y * 10
end

function CurvedPipe:predraw(dt)
    local fullBackground = {
        self.pos.x - SIZE / 2, self.pos.y - SIZE / 2,
        self.pos.x + SIZE / 2, self.pos.y - SIZE / 2,
        self.pos.x + SIZE / 2, self.pos.y + SIZE / 2,
        self.pos.x - SIZE / 2, self.pos.y + SIZE / 2
    }

    if self.lifted then
        -- Background from the lifted piece
        love.graphics.setColor(0x57, 0x5d, 0x60, 0xFF)
        love.graphics.polygon(
            'fill',
            self.normalPos.x - SIZE / 2, self.normalPos.y - SIZE / 2,
            self.normalPos.x + SIZE / 2, self.normalPos.y - SIZE / 2,
            self.normalPos.x + SIZE / 2, self.normalPos.y + SIZE / 2,
            self.normalPos.x - SIZE / 2, self.normalPos.y + SIZE / 2
        )

        -- Background OF the lifted piece
        love.graphics.setColor(0xC3, 0xC3, 0xC3, 0xFF)
        love.graphics.polygon('fill', fullBackground)
        love.graphics.setColor(0xFF, 0xFF, 0xFF, 0xFF)
        return
    end

    -- No fluid
    if self.fluidProgress == 0 then return end

    love.graphics.setColor(0, 0xFF, 0, 0xFF)
    -- All fluid
    if self.fluidProgress == 1 then
        love.graphics.polygon('fill', fullBackground)
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
            -- Flip depending on which side of the pipe the fluid enters
            if self.clockwise then
                coord = {x = -coord.y, y = -coord.x}
            end

            -- Rotate depending on the rotation of the pipe
            coord = rotateCoords(coord.x, coord.y, self.rotation)

            -- `polygon` wants a flattened array-table for some reason ᖍ(ツ)ᖌ
            table.insert(flattenedVertices, coord.x + self.pos.x)
            table.insert(flattenedVertices, coord.y + self.pos.y)
        end
        love.graphics.polygon('fill', flattenedVertices)
    end
    love.graphics.setColor(0xFF, 0xFF, 0xFF, 0xFF)
end

function CurvedPipe:draw()
    if self.highlighted then
        love.graphics.draw(self.hilite,
            self.pos.x, self.pos.y, 0, 1, 1, 25, 25)
    end
end

function CurvedPipe:canMove()
    return not self.filling and self.fluidProgress == 0
end

function CurvedPipe:outDirection()
    local rot = self.rotation
    if self.clockwise then
        rot = rot - 1
    end

    local rotated = rotateCoords(-1, 0, rot)
    return {
        dx = rotated.x,
        dy = rotated.y,
        x = self.pipeCoordinate.x + rotated.x,
        y = self.pipeCoordinate.y + rotated.y
    }
end

function CurvedPipe:acceptFrom(direction)
    if self.lifted then
        return nil
    end
    local rotated = rotateCoords(direction.x, direction.y, -self.rotation)
    if rotated.y == 1 then
        self.clockwise = false
        return true
    elseif rotated.x == -1 then
        self.clockwise = true
        return true
    end
    return nil
end

return CurvedPipe
