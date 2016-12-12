local CutsceneDrawSystem = Class{}
CutsceneDrawSystem = tiny.processingSystem(CutsceneDrawSystem)

function CutsceneDrawSystem:init()
    self.isDrawingSystem = true
    self.filter = tiny.requireAll('isCutscene')
    self.particleSprite = love.graphics.newImage("assets/images/2x2whitesquare.png")
    local ps = love.graphics.newParticleSystem( self.particleSprite, 3000 )
    self.ps = ps
    ps:setParticleLifetime(10, 10) -- Particles live at least 10s and at most 10s.
    ps:setSpeed(-1200, -100)
    ps:setEmissionRate(32)
    -- ps:setLinearAcceleration(-50, -1, -30, 1)
    ps:setAreaSpread( 'uniform', 0, love.graphics.getHeight() * 0.5 )
end

function CutsceneDrawSystem:preProcess(dt)
end

function CutsceneDrawSystem:postProcess(dt)
    love.graphics.setColor(255, 255, 255, 255)
end

function CutsceneDrawSystem:process(e, dt)
    if not Global.isCutscene then return end

    -- draw space
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', 0, 0, 800, 600)

    -- draw ship
    local sPos = {
        x = 340,
        y = 360
    }
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.polygon('fill',
        sPos.x, sPos.y - 15,
        sPos.x, sPos.y + 15,
        sPos.x + 30, sPos.y
    )

    self.ps:update(dt)
    love.graphics.draw(self.ps, love.graphics.getWidth(), love.graphics.getHeight() * 0.5)
end

return CutsceneDrawSystem
