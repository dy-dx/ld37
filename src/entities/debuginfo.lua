local DebugInfo = Class{}

function DebugInfo:init()
    self.isDebugInfo = true
    self.dangerLevels = {
        nav = 0,
        ventgas = 0,
        spinner = 0,
        misslowcommand = 0,
        plumbing = 0,
    }
    Signal.register('dangerLevel', function(gamename, level)
        self.dangerLevels[gamename] = level
    end)
end

return DebugInfo
