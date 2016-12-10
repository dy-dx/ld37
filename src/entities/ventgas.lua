local VentGas = Class{}
local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

function VentGas:init()
    self.isDrawVentGasSystem = true
    self.isVentGasControlSystem = true
    self.isVisible = true
    self.x = 0
    self.y = 0
    self.width = screenWidth
    self.height = screenHeight*2/3
    self.r = 10
    self.g = 175
    self.b = 35

    -- gas pressure
    self.gasPressureDecrease = 100
    self.gasGrowthRate = 1
    self.maxGasPressure = 300
    self.currentGasPressure = 0
    self.gasPressureBox = {x = screenWidth*1/4
        , y = 20, width = 60
        , height = self.maxGasPressure, r=25, g=25, b=75
        }
    self.gasPressureButton = {x=self.gasPressureBox.x + 30
        , y=self.gasPressureBox.y + self.gasPressureBox.height + 40
        , radius=30, r=0, g=255, b=40, text='Press Here'}

    -- oxygen
    self.maxOxygenPressure = 300
    self.oxygenPressureBox = {x = screenWidth*2/4
        , y = 20, width = 60
        , height = self.maxOxygenPressure, r=25, g=25, b=75
        }
    self.oxygenPressureButton = {x=self.oxygenPressureBox.x + 30
        , y=self.oxygenPressureBox.y + self.oxygenPressureBox.height + 40
        , radius=30, r=0, g=255, b=40, text='DO NOT Press Here'}

    -- unknown pressure
    self.unknownPressureDecrease = 50
    self.unknownGrowthRate = 1.5
    self.maxUnknownPressure = 300
    self.currentUnknownPressure = 0
    self.unknownPressureBox = {x = screenWidth*3/4
        , y = 20, width = 60
        , height = self.maxUnknownPressure, r=25, g=25, b=75
        }
    self.currentunknownPressure = 0
    self.unknownPressureButton = {x=self.unknownPressureBox.x + 30
        , y=self.unknownPressureBox.y + self.unknownPressureBox.height + 40
        , radius=30, r=0, g=255, b=40, text='Press Here'}
end

return VentGas
