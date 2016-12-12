-- 611 165

local EndBuffer = Class{}

function EndBuffer:init()
    self.plumbing = true
    self.type = 'endbuffer'
    self.pos = {x = 602, y = 94}

    self.sprite = love.graphics.newImage('assets/images/plumbingStartBuffer.png')

    self.fluidProgress = 0
    self.filling = false
    self.isDead = false

    self.drawId = -11
end

function EndBuffer:predraw(dt)
    love.graphics.setColor(0, 0xFF, 0, 0xFF)

    -- 91, 417
    local RIGHT = 152
    local fluidLevel = RIGHT - (RIGHT - 91) * self.fluidProgress
    love.graphics.polygon(
        'fill',
        fluidLevel, 415,
        fluidLevel, 425,
        RIGHT, 425,
        RIGHT, 415
    )

    love.graphics.setColor(0xFF, 0xFF, 0xFF, 0xFF)
end

function EndBuffer:acceptFrom(direction)
    return {}
    -- error("fuck shit up")
    -- return {
    --     x = 9,
    --     y = 0,
    --     dx = -1,
    --     dy = 0
    -- }
end

return EndBuffer
