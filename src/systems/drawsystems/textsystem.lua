local TextSystem = Class{}
TextSystem = tiny.processingSystem(TextSystem)

local Utils = require('utils')

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
    local distance = (e.time * e.speed) / 1000

    if(distance > string.len(e.text)) then
        return string.len(e.text)
    else
        return math.floor(distance)
    end
end

function TextSystem:chunkText(e, font, textString)

    local chunks = Utils.split(textString, "%S+")

    local linesChunks = lume.reduce(chunks, function(memo, chunk)
        local lastChunk = lume.last(memo)

        local testChunks = lume.concat(lastChunk, {chunk})
        if(font:getWidth(table.concat(testChunks, ' ')) < e.maxWidth) then
            memo[table.getn(memo)] = testChunks
        else
            lume.push(memo, { chunk })
        end
        return memo

    end, {{}})

    return lume.map(linesChunks, function(line) return table.concat(line, ' ') end);
end

function TextSystem:printLine(line, height, idx)
    local font = love.graphics.newFont(20)
    local text = love.graphics.newText(font, line)

    love.graphics.draw(text, windowWidth / 2 - font:getWidth(line) / 2, height + idx * font:getHeight(line))
end

function TextSystem:printLines(e, lines)
    local font = love.graphics.newFont(20)
    local firstLineText = love.graphics.newText(font, lume.first(lines))

    local i = 1
    lume.map(lines, function(line)
        TextSystem:printLine(line, e.textHeight - font:getHeight(firstLineText) * table.getn(lines)/ 2, i)
        i = i + 1
    end)
end

function TextSystem:printText(e, charactersDisplayed)
    local partialText = string.sub(e.text, 1, charactersDisplayed) or ""
    local font = love.graphics.newFont(20)
    local text = love.graphics.newText(font, partialText)
    local textChunks = self:chunkText(e, font, partialText)
    self:printLines(e, textChunks)
end

function TextSystem:process(e, dt)
    e.time = e.time + dt;
    local charactersDisplayed = self:getCharactersDisplayed(e)

    if(e.prevTextLen < charactersDisplayed) then
        Signal.emit('talk');
        e.prevTextLen = charactersDisplayed
    end

    self:printText(e, charactersDisplayed)
end

return TextSystem
