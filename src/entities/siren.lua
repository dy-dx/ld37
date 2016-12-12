local anim8 = require 'vendor/anim8'
local Siren = Class{}

-- types: sirens_side, sirens_mid_side
function Siren:init(sirenType, xPos, yPos, flipHorizontally, gamename)
    self.isSirenAnimationSystem=true
    self.pos = {x = xPos, y = yPos}
    self.flipHorizontally = flipHorizontally
    self.gamename = gamename
    self.sirenRate = .3
    self.nframes = 3
    self.sirenOffImage = love.graphics.newImage('assets/images/sirens/' .. sirenType .. '_off.png')
    self.sirenOnSheet = love.graphics.newImage('assets/images/sirens/' .. sirenType .. '_on_sheet.png')
    local sirenOnGrid = anim8.newGrid(self.sirenOnSheet:getWidth()/self.nframes, self.sirenOnSheet:getHeight(), self.sirenOnSheet:getWidth(), self.sirenOnSheet:getHeight())
    self.animationSirenOn = anim8.newAnimation(sirenOnGrid('1-' .. self.nframes, 1), self.sirenRate)
    self.isAnimated = false
    self.sprite = self.sirenOffImage
    self.animation = nil
    self.dangerLevel = 1
    Signal.register('dangerLevel', function(gamename, level)
        if gamename == self.gamename then
            self.dangerLevel = level
        end
    end)
end

return Siren
