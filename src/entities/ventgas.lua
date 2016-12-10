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
    self.maxGasPressure = 300
    self.gasGrowthRate = 1
    self.gasPressureBox = {x = screenWidth/3
        , y = 20, width = 60
        , height = self.maxGasPressure, r=25, g=25, b=75
        }
    self.currentGasPressure = 0
    self.gasPressureButton = {x=self.gasPressureBox.x + 30
        , y=self.gasPressureBox.y + self.gasPressureBox.height + 40
        , radius=30, r=0, g=255, b=40, text='Press Here'}
    self.gasPressureMeter = {r=255, g=0, b=0
        , x=self.gasPressureBox.x
        , y=self.gasPressureBox.y + self.gasPressureBox.height
        , width=self.gasPressureBox.width, height=10}
end

return VentGas
