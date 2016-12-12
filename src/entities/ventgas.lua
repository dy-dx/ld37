local VentGas = Class{}

function VentGas:init()

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local padding = 40
    local barPadding = 60
    local barWidth = 60
    local barHeight = 280

    self.isDrawVentGasSystem = true
    self.isVentGasControlSystem = true
    -- percentages used to invoke danger signal switches
    self.dangerLevelTwoPercentage = .6
    self.dangerLevelThreePercentage = .8
    self.x = padding
    self.y = padding
    self.width = screenWidth - 2 * padding
    self.height = screenHeight - 2 * padding * 1.5
    self.r = 188
    self.g = 198
    self.b = 204

    self.gasButtonSprite = love.graphics.newImage('assets/images/ventgas/button_left.png')
    self.gasButtonPressedSprite = love.graphics.newImage('assets/images/ventgas/button_left_pressed.png')
    self.oxygenButtonSprite = love.graphics.newImage('assets/images/ventgas/button_middle.png')
    self.oxygenButtonPressedSprite = love.graphics.newImage('assets/images/ventgas/button_middle_pressed.png')
    self.wasteButtonSprite = love.graphics.newImage('assets/images/ventgas/button_right.png')
    self.wasteButtonPressedSprite = love.graphics.newImage('assets/images/ventgas/button_right_pressed.png')
    self.tapeSprite = love.graphics.newImage('assets/images/ventgas/tape.png')

    -- gas
    self.gasPressureBox = {x = self.width*1/4
        , y = self.y + barPadding, width = barWidth
        , height = barHeight, r=25, g=25, b=75
    }

    -- oxygen
    self.maxOxygenPressure = maxPressure
    self.oxygenPressureBox = {x = self.width*2/4
        , y = self.y + barPadding, width = barWidth
        , height = barHeight, r=25, g=25, b=75
    }

    -- waste
    self.wastePressureBox = {x = self.width*3/4
        , y = self.y + barPadding, width = barWidth
        , height = barHeight, r=25, g=25, b=75
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
    local gasGrowthRate = 5
    local wasteGrowthRate = 10
    -- Decrease Rates - decrease to make more difficult
    local gasPressureDecrease = 50
    local wastePressureDecrease = 50

    self.dangerLevel = 1

    self.gasLevelTwoLowerBound = gasMaxPressure*self.dangerLevelTwoPercentage
    self.gasLevelThreeLowerBound = gasMaxPressure*self.dangerLevelThreePercentage
    self.wasteLevelTwoLowerBound = wasteMaxPressure*self.dangerLevelTwoPercentage
    self.wasteLevelThreeLowerBound = wasteMaxPressure*self.dangerLevelThreePercentage

    self.gasMeter = {pressureDecrease = gasPressureDecrease, growthRate = gasGrowthRate
        , maxPressure = gasMaxPressure, currentPressure = 0}
    self.gasPressureButton = {x=self.gasPressureBox.x + buttonRadius
        , y=self.gasPressureBox.y + self.gasPressureBox.height + buttonYOffset
        , radius=buttonRadius, r=0, g=255, b=40, buttonDown = false, text = 'test'
        , buttonSprite = self.gasButtonSprite, buttonPressedSprite = self.gasButtonPressedSprite
        , buttonType = 'gas'
    }
    self.oxygenPressureButton = {x=self.oxygenPressureBox.x + buttonRadius
        , y=self.oxygenPressureBox.y + self.oxygenPressureBox.height + buttonYOffset
        , radius=buttonRadius, r=0, g=255, b=40, buttonDown = false, text= 'test'
        , buttonSprite = self.oxygenButtonSprite, buttonPressedSprite = self.oxygenButtonPressedSprite
        , buttonType = 'oxygen'
    }
    self.wasteMeter = {pressureDecrease = wastePressureDecrease, growthRate = wasteGrowthRate
        , maxPressure = wasteMaxPressure, currentPressure = 0}
    self.wastePressureButton = {x=self.wastePressureBox.x + buttonRadius
        , y=self.wastePressureBox.y + self.wastePressureBox.height + buttonYOffset
        , radius=buttonRadius, r=0, g=255, b=40, text = 'test'
        , buttonSprite = self.wasteButtonSprite, buttonPressedSprite = self.wasteButtonPressedSprite
        , buttonType = 'waste'
    }

end
return VentGas
