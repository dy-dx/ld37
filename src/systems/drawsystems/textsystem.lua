local TextSystem = Class{}
TextSystem = tiny.processingSystem(TextSystem)

local windowWidth  = love.graphics.getWidth()

function TextSystem:init()
    self.isDrawingSystem = true
    self.filter = tiny.requireAll('text')
end

function TextSystem:preProcess(dt)
    love.graphics.setColor(255, 255, 255, 255)
end

function TextSystem:postProcess(dt)
    love.graphics.setColor(255, 255, 255, 255)
end

function TextSystem:getCharactersDisplayed(e)
    print("e.time = " .. e.time)
    print("e.speed = " .. e.speed)
    local distance = (e.time * e.speed) / 1000

    print("distance = " .. distance)
    if(distance > string.len(e.text)) then
        return string.len(e.text)
    else
        return math.floor(distance)
    end
end

function TextSystem:printText(e, charactersDisplayed)
    print("charactersDisplayed = " .. charactersDisplayed)

    local partialText = string.sub(e.text, 1, charactersDisplayed)

    local font = love.graphics.newFont(30)
    local text = love.graphics.newText(font, partialText)

    love.graphics.draw(text, windowWidth / 2 - font:getWidth(partialText) / 2, e.textHeight - font:getHeight(partialText) / 2)
end

function TextSystem:process(e, dt)
    e.time = e.time + dt;

    print("e.text = " .. e.text)

    local charactersDisplayed = self:getCharactersDisplayed(e)

    self:printText(e, charactersDisplayed)
end

return TextSystem
