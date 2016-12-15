local anim8 = require 'vendor/anim8'
local Behavior = require 'vendor/knife.behavior'
local Cutscene = Class{}

function Cutscene:init()
    self.isCutscene = true
    self.dialogueFont = love.graphics.newFont(20)
    self.gameoverFont = love.graphics.newFont(32)
    self.sprite = nil
    self.animation = nil
    self.shipSheet = love.graphics.newImage('assets/images/ship_sheet.png')
    self.explosionSheet = love.graphics.newImage('assets/images/explosion_sheet.png')
    local g1 = anim8.newGrid(50, 45, self.shipSheet:getWidth(), self.shipSheet:getHeight())
    self.shipAnimation = anim8.newAnimation(g1('1-2', 1), 0.1)
    local g2 = anim8.newGrid(100, 100, self.explosionSheet:getWidth(), self.explosionSheet:getHeight())
    self.explosionAnimation = anim8.newAnimation(g2('1-9', 1, '1-9', 2, '1-9', 3, '1-9', 4, '1-9', 5, '1-9', 6, '1-9', 7, '1-9', 8, '1-9', 9), 0.03, 'pauseAtEnd')

    self.timer = Timer.new()
    self.wobbleTimer = Timer.new()

    self.maxTextWidth = 480
    self.textSpeed = 25000
    self:resetState()
    Signal.register('startCutscene', function(cutsceneType)
        self:resetState(cutsceneType)
        if cutsceneType == 'gameover' then
            Signal.emit('transitionMusic', 'calm', 1.0)
            self.behavior.setState(self.behavior, 'enterGameover')
        else
            Signal.emit('transitionMusic', 'calm', 0.5)
            self.behavior.setState(self.behavior, 'enterNarrative')
        end

        -- just in case
        Signal.emit('stopsludge')
        Signal.emit('stopwoosh')
        Signal.emit('stopspray')
    end)

    -- knife.behavior state machine
    self.states = {
        default = {
            { duration = 0, after = 'intro' },
        },
        intro = {
            { duration = 0, after = 'enterNarrative' },
        },
        enterNarrative = {
            { duration = 0, action = function() self:hideBridge() end },
            { duration = 0.4, after = 'enterPrintNarrativeLine' },
        },
        -- during text printing sequence
        enterPrintNarrativeLine = {
            { duration = math.huge, action = function()
                self:resetLine()
                self.currentDialogueIndex = self.currentDialogueIndex + 1
                if self.currentDialogueIndex > table.getn(Global.currentLevelDefinition.cutsceneDialogue) then
                    self.behavior.setState(self.behavior, 'enterOutro')
                elseif string.sub(Global.currentLevelDefinition.cutsceneDialogue[self.currentDialogueIndex], 1, 9) == 'setState:' then
                    -- ohh what a hack. i have outdone myself
                    local line = Global.currentLevelDefinition.cutsceneDialogue[self.currentDialogueIndex]
                    local state = string.sub(line, 10, string.len(line))
                    self.behavior.setState(self.behavior, state)
                else
                    self.behavior.setState(self.behavior, 'printNarrativeLine')
                end
            end },
        },
        printNarrativeLine = {
            { duration = math.huge, skipTo = 'narrativeLineWaiting' },
        },
        -- when entire line is printed out
        narrativeLineWaiting = {
            { duration = math.huge, skipTo = 'enterPrintNarrativeLine' },
        },
        enterOutro = {
            { duration = 0.5, after = 'outro', action = function() self:revealBridge(0.5) end },
        },
        outro = {
            { duration = 0, after = 'endCutscene' },
        },
        endCutscene = {
            { duration = math.huge },
        },
        enterGameover = {
            { duration = 0, after = 'gameover' },
        },
        gameover = {
            { duration = 0.4 },
            { duration = 2.6, after = 'gameoverWaiting', skipTo = 'gameoverWaiting' },
        },
        gameoverWaiting = {
            { duration = math.huge, skipTo = 'endCutscene' }
        },
        enterTheEnd = {
            { duration = 0, after = 'theEnd' }
        },
        theEnd = {
            { duration = math.huge }
        },
        enterIntroWobble = {
            { duration = 0.1, after = 'introWobble' }
        },
        introWobble = {
            { duration = 1, after = 'enterPrintNarrativeLine', action = function() self:startWobbling() end },
        },
        revealBridge = {
            { duration = 1.1, after = 'enterPrintNarrativeLine', action = function() self:revealBridge(0.8) end },
        },
        hideBridge = {
            { duration = 1.1, after = 'enterPrintNarrativeLine', action = function() self:hideBridge(1.0) end },
        },
        -- holy shit the hacks
        highlightNav =            {{ duration = 0, after = 'enterPrintNarrativeLine', action = function() self:highlightScreen('nav') end }},
        highlightVentgas =        {{ duration = 0, after = 'enterPrintNarrativeLine', action = function() self:highlightScreen('ventgas') end }},
        highlightSpinner =        {{ duration = 0, after = 'enterPrintNarrativeLine', action = function() self:highlightScreen('spinner') end }},
        highlightMisslowcommand = {{ duration = 0, after = 'enterPrintNarrativeLine', action = function() self:highlightScreen('misslowcommand') end }},
        highlightPlumbing =       {{ duration = 0, after = 'enterPrintNarrativeLine', action = function() self:highlightScreen('plumbing') end }},
    }
    self.behavior = Behavior(self.states)
end

function Cutscene:revealBridge(time)
    if Global.isGameWon then
        -- sorry, not sorry
        return
    end
    self.isBridgeRevealed = true
    self.timer:tween(time or 0.5, self, {alpha = 0, cutsceneAlpha = 0}, 'linear')
end

function Cutscene:hideBridge(time)
    self.isBridgeRevealed = false
    self.timer:tween(time or 0.5, self, {alpha = 1, cutsceneAlpha = 255}, 'linear')
end

local randomEase = function()
    local eases = {
         'linear', 'linear', 'linear', 'out-bounce', 'in-out-quad',  'bounce'
    }
    return eases[math.random(#eases)]
end

function Cutscene:startWobbling()
    local up, down, wob_back, wob_forth
    up = function()
        self.wobbleTimer:tween(0.3, self.pos, {y = self.pos.y - 10}, 'linear', down)
    end
    down = function()
        self.wobbleTimer:tween(0.5, self.pos, {y = self.pos.y + 10}, 'linear', up)
    end

    wob_back = function()
        self.wobbleTimer:tween(0.5, self, {rot = -0.1}, randomEase(), wob_forth)
    end
    wob_forth = function()
        self.wobbleTimer:tween(0.5, self, {rot = 0.1}, randomEase(), wob_back)
    end

    up()
    wob_back()
end

function Cutscene:stopWobbling() -- but why would you ever want to?
    self.wobbleTimer:clear()
end

function Cutscene:highlightScreen(gamename)
    Signal.emit('dangerLevel', gamename, -1)
end

function Cutscene:resetLine()
    self.textTime = 0
    self.currentCharacter = 1
end

function Cutscene:resetState(cutsceneType)
    self:resetLine()
    self.timer:clear()
    self.sprite = self.shipSheet
    self.animation = self.shipAnimation
    self.pos = {x = 330, y = 330}
    self.alpha = 1
    self.cutsceneAlpha = 255
    self.rot = 0
    self.offset = {x = 0, y = 0}
    self.gameOverText = ''
    self.cutsceneType = 'intro'
    self.currentDialogueIndex = 0
    self.isBridgeRevealed = false

    -- oh god i hope this works to reset those sirens
    Signal.emit('dangerLevel', 'nav', 1)
    Signal.emit('dangerLevel', 'ventgas', 1)
    Signal.emit('dangerLevel', 'spinner', 1)
    Signal.emit('dangerLevel', 'misslowcommand', 1)
    Signal.emit('dangerLevel', 'plumbing', 1)

    -- explosion sequence
    if cutsceneType == 'gameover' then
        self.cutsceneType = 'gameover'
        self.timer:script(function(wait)
            self.timer:tween(
                2, -- seconds
                self.pos,
                { x = self.pos.x + 40 },
                'linear'
            )
            wait(2)
            Signal.emit('ded')
            self:stopWobbling()
            self.wobbleTimer:after(2.5, function() self:startWobbling() end)
            self.offset = {x = 25, y = 30}
            self.sprite = self.explosionSheet
            self.animation = self.explosionAnimation
            self.animation:gotoFrame(1)
            self.animation:resume()
            wait(1)
            self.gameOverText = 'Game Over'
        end)
    end
end

return Cutscene
