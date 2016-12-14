local VentGas = Class{}

function VentGas:init()

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local padding = 40
    local barPadding = 60
    local barWidth = 69
    local barHeight = 323

    self.isDrawVentGasSystem = true
    self.isVentGasControlSystem = true
    -- time used to invoke danger signal switches
    self.timeLeftToTriggerDangerLevelTwo = 8
    self.timeLeftToTriggerDangerLevelThree = 5
    self.x = padding
    self.y = padding
    self.width = screenWidth - 2 * padding
    self.height = screenHeight - 2 * padding * 1.5
    self.r = 188
    self.g = 198
    self.b = 204

    self.panelSprite = love.graphics.newImage('assets/images/ventgas/panel2.png')
    self.gasButtonSprite = love.graphics.newImage('assets/images/ventgas/button_left.png')
    self.gasButtonPressedSprite = love.graphics.newImage('assets/images/ventgas/button_left_pressed.png')
    self.oxygenButtonSprite = love.graphics.newImage('assets/images/ventgas/button_middle.png')
    self.oxygenButtonPressedSprite = love.graphics.newImage('assets/images/ventgas/button_middle_pressed.png')
    self.wasteButtonSprite = love.graphics.newImage('assets/images/ventgas/button_right.png')
    self.wasteButtonPressedSprite = love.graphics.newImage('assets/images/ventgas/button_right_pressed.png')
    self.tapeSprite = love.graphics.newImage('assets/images/ventgas/tape.png')

    -- gas
    self.gasPressureBox = {x = 146
        , y = self.y + barPadding - 44, width = barWidth
        , height = barHeight, r=30, g=30, b=50
    }

    -- oxygen
    self.oxygenPressureBox = {x = 354
        , y = self.y + barPadding - 42, width = barWidth
        , height = barHeight, r=30, g=30, b=50
    }

    -- waste
    self.wastePressureBox = {x = 564
        , y = self.y + barPadding - 44, width = barWidth
        , height = barHeight, r=30, g=30, b=50
    }
    self:resetState()
    Signal.register('startLevel', function(level)
        self:resetState()
    end)
end

function VentGas:resetState()
    local buttonRadius = 30
    local buttonYOffset = 40
    local gasMaxPressure = 300
    local wasteMaxPressure = 300
    -- Growth Rates - increase to make more difficult
    local gasGrowthRate = Global.currentLevelDefinition.ventgas.gasGrowthRate
    local wasteGrowthRate = Global.currentLevelDefinition.ventgas.wasteGrowthRate
    -- Decrease Rates - decrease to make more difficult
    local gasPressureDecrease = 120
    local wastePressureDecrease = 120
    -- Initial conditions
    local initialGasPressure = Global.currentLevelDefinition.ventgas.initialGas
    local initialWastePressure = Global.currentLevelDefinition.ventgas.initialWaste

    -- defaults
    if not initialGasPressure then initialGasPressure = 0 end
    if not initialWastePressure then initialWastePressure = 0 end
    if not gasGrowthRate then gasGrowthRate = 10 end
    if not wasteGrowthRate then wasteGrowthRate = 10 end

    self.dangerLevel = 1

    self.gasMeter = {pressureDecrease = gasPressureDecrease, growthRate = gasGrowthRate
        , maxPressure = gasMaxPressure, currentPressure = initialGasPressure}
    self.gasPressureButton = {x=self.gasPressureBox.x + buttonRadius
        , y=self.gasPressureBox.y + self.gasPressureBox.height + buttonYOffset
        , radius=buttonRadius, r=0, g=255, b=40, buttonDown = false, text = 'test'
        , buttonSprite = self.gasButtonSprite, buttonPressedSprite = self.gasButtonPressedSprite
        , buttonType = 'gas'
    }
    self.oxygenMeter = {pressureDecrease = 0, growthRate = 0
        , maxPressure = 300, currentPressure = 140}
    self.oxygenPressureButton = {x=self.oxygenPressureBox.x + buttonRadius
        , y=self.oxygenPressureBox.y + self.oxygenPressureBox.height + buttonYOffset
        , radius=buttonRadius, r=0, g=255, b=40, buttonDown = false, text= 'test'
        , buttonSprite = self.oxygenButtonSprite, buttonPressedSprite = self.oxygenButtonPressedSprite
        , buttonType = 'oxygen'
    }
    self.wasteMeter = {pressureDecrease = wastePressureDecrease, growthRate = wasteGrowthRate
        , maxPressure = wasteMaxPressure, currentPressure = initialWastePressure}
    self.wastePressureButton = {x=self.wastePressureBox.x + buttonRadius
        , y=self.wastePressureBox.y + self.wastePressureBox.height + buttonYOffset
        , radius=buttonRadius, r=0, g=255, b=40, text = 'test'
        , buttonSprite = self.wasteButtonSprite, buttonPressedSprite = self.wasteButtonPressedSprite
        , buttonType = 'waste'
    }

end
return VentGas
