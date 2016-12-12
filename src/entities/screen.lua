local Screen = Class{}

function Screen:init(mask, gamename)
  self.isScreen=true
  self.dangerLevel = 1
  self.alertMask = love.graphics.newImage(mask)
  self.gamename = gamename

  Signal.register(
    'dangerLevel',
    function(gamename, level)
      if gamename == self.gamename then
        self.dangerLevel = level
      end
    end
  )
end

return Screen
