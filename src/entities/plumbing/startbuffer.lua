-- 611 165

local StartBuffer = Class{}

function StartBuffer:init()
    self.plumbing = true
    self.pos = {x = 602, y = 94}

    self.sprite = love.graphics.newImage('assets/images/plumbingStartBuffer.png')

    self.fluidProgress = 0
    self.filling = true
    self.isDead = false

    self.drawId = -10
end

function StartBuffer:predraw(dt)
    love.graphics.setColor(0, 0xFF, 0, 0xFF)

    local MAIN_TIME = 0.75
    local CURVE_TIME = 0.15
    local TOTAL = MAIN_TIME + CURVE_TIME

    -- MAIN RECT
    local scale = math.min(self.fluidProgress / MAIN_TIME, 1)
    local BOTTOM = 318
    local fluidLevel = BOTTOM - (BOTTOM - 145) * scale
    love.graphics.polygon(
        'fill',
        612, fluidLevel,
        702, fluidLevel,

        702, BOTTOM,
        612, BOTTOM
    )

    -- CURVE PART
    if self.fluidProgress > MAIN_TIME then
        local scale = math.min((self.fluidProgress - MAIN_TIME) / CURVE_TIME, 1) * 50
        love.graphics.polygon(
            'fill',
            687 - scale, 145 - scale,  -- top left (i move!)
            637, 145,  -- bottom left
            687, 145  -- bottom right
        )
    end

    -- LAST STRAIGHTAWAY
    if self.fluidProgress > TOTAL then

        local scale = math.min((self.fluidProgress - TOTAL) / (1 - TOTAL), 1)
        local RIGHT = 637
        local fluidLevel = RIGHT - (RIGHT - 602) * scale
        love.graphics.polygon(
            'fill',
            fluidLevel, 95,
            fluidLevel, 145,
            637, 145,
            637, 95
        )
    end
    love.graphics.setColor(0xFF, 0xFF, 0xFF, 0xFF)
end

function StartBuffer:outDirection()
    return {
        x = 9,
        y = 0,
        dx = -1,
        dy = 0
    }
end

return StartBuffer
