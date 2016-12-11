local StraightPipe = Class{}

local SIZE = 50


function StraightPipe:init(x, y, offsetX, offsetY, rotation)
    self.plumbing = true
    self.isStraight = true
    self.lifted = false
    self.pipeCoordinate = {x = x, y = y}
    self.normalPos = {
        x = x * SIZE + offsetX,
        y = y * SIZE + offsetY
    }
    self.pos = self.normalPos
    self.rotation = rotation  -- this is for the game logic stuff, [0, 1]
    self.rot = rotation * math.pi / 2  -- this is for the display stuff, [0, 2π)
    self.sprite = love.graphics.newImage('assets/images/pipeLR.png')
    self.offset = {
        x = self.sprite:getWidth() / 2,
        y = self.sprite:getHeight() / 2
    }
    self.readingDirection = true
    self.isDead = false
    self.filling = false
    self.fluidProgress = 0
    -- default draw order
    self.drawId = x + y * 10
end

function StraightPipe:predraw(dt)
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
        -- originally, vertices refers to a left-to-right line
        local vertices = {
            {x = -SIZE / 2, y = SIZE / 2},  -- bottom left
            {x = -SIZE / 2, y = -SIZE / 2},  -- top left
            -- top left to top right
            {x = -SIZE / 2 + self.fluidProgress * SIZE, y = -SIZE / 2},
            -- bottom left to bottom right
            {x = -SIZE / 2 + self.fluidProgress * SIZE, y = SIZE / 2}
        }
        local flattenedVertices = {}
        for k, coord in ipairs(vertices) do
            local x, y = coord.x, coord.y

            -- Flip depending on which side of the pipe the fluid enters
            if not self.readingDirection then
                x, y = -x, -y
            end

            -- Rotate depending on the rotation of the pipe
            if self.rotation == 1 then
                y, x = x, -y
            end

            -- `polygon` wants a flattened array-table for some reason ᖍ(ツ)ᖌ
            table.insert(flattenedVertices, x + self.pos.x)
            table.insert(flattenedVertices, y + self.pos.y)
        end
        love.graphics.polygon('fill', flattenedVertices)
    end
    love.graphics.setColor(0xFF, 0xFF, 0xFF, 0xFF)
end

function StraightPipe:canMove()
    return not self.filling and self.fluidProgress == 0
end

function StraightPipe:outDirection()
    local vector = -1
    if self.readingDirection then
        vector = 1
    end
    if self.rotation == 0 then
        return {
            x = self.pipeCoordinate.x + vector,
            y = self.pipeCoordinate.y,
            dx = vector,
            dy = 0
        }
    end
    return {
        x = self.pipeCoordinate.x,
        y = self.pipeCoordinate.y + vector,
        dx = 0,
        dy = vector
    }
end

function StraightPipe:acceptFrom(direction)
    if self.lifted then
        return nil
    end
    if (direction.x == 0) == (self.rotation == 1) then
        self.readingDirection = (direction.x < 0 or direction.y < 0)
        return true
    end
    return nil
end

return StraightPipe
