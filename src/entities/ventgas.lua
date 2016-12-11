local VentGas = Class{}

function VentGas:init()

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local padding = 40
    local barPadding = 20
    local barWidth = 60
    local buttonRadius = 30
    local buttonYOffset = 40
    local maxPressure = 300

    self.isDrawVentGasSystem = true
    self.isVentGasControlSystem = true
    self.x = padding
    self.y = padding
    self.width = screenWidth - 2 * padding
    self.height = screenHeight - 2 * padding * 1.5
    self.r = 10
    self.g = 175
    self.b = 35

    -- gas pressure
    self.gasMeter = {pressureDecrease = 50, growthRate = 5
        , maxPressure = maxPressure, currentPressure = 0}
    self.gasPressureBox = {x = self.width*1/4
        , y = self.y + barPadding, width = barWidth
        , height = self.gasMeter.maxPressure, r=25, g=25, b=75
        }
    self.gasPressureButton = {x=self.gasPressureBox.x + buttonRadius
        , y=self.gasPressureBox.y + self.gasPressureBox.height + buttonYOffset
        , radius=buttonRadius, r=0, g=255, b=40, text='Press Here'}

    -- oxygen
    self.maxOxygenPressure = maxPressure
    self.oxygenPressureBox = {x = self.width*2/4
        , y = self.y + barPadding, width = barWidth
        , height = self.maxOxygenPressure, r=25, g=25, b=75
        }
    self.oxygenPressureButton = {x=self.oxygenPressureBox.x + buttonRadius
        , y=self.oxygenPressureBox.y + self.oxygenPressureBox.height + buttonYOffset
        , radius=buttonRadius, r=0, g=255, b=40, text='DO NOT Press Here'}

    -- unknown pressure
    self.unknownMeter = {pressureDecrease = 50, growthRate = 10
        , maxPressure = maxPressure, currentPressure = 0}
    self.unknownPressureBox = {x = self.width*3/4
        , y = self.y + barPadding, width = barWidth
        , height = self.unknownMeter.maxPressure, r=25, g=25, b=75
        }
    self.unknownPressureButton = {x=self.unknownPressureBox.x + buttonRadius
        , y=self.unknownPressureBox.y + self.unknownPressureBox.height + buttonYOffset
        , radius=buttonRadius, r=0, g=255, b=40, text='Press Here'}
end

return VentGas
