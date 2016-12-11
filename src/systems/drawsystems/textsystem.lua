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

function TextSystem:printLine(line, x, y, idx)
    local font = love.graphics.newFont(20)
    local text = love.graphics.newText(font, line)

    love.graphics.draw(text, x, y + idx * font:getHeight(line))
end

function TextSystem:printLines(e, lines)
    local font = love.graphics.newFont(20)
    local firstLineText = love.graphics.newText(font, lume.first(lines))

    local i = 1
    lume.map(lines, function(line)
        TextSystem:printLine(line, e.textX, e.textY, i)
        i = i + 1
    end)
end

function TextSystem:chunkText(e, textString)

    local font = love.graphics.newFont(20)
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

function TextSystem:printText(e, charactersDisplayed)

    local partialText = string.sub(e.text, 1, charactersDisplayed) or ""
    local textChunks = self:chunkText(e, partialText)

    local prevChunks = lume.each(e.savedText, function (line)
        return self:chunkText(e, line)
    end)

    self:printLines(e, lume.concat(lume.concat(prevChunks), textChunks))

end

function TextSystem:process(e, dt)
    local prevLen = table.getn(e.savedText)
    if(prevLen > 5) then
        e.savedText = lume.slice(e.savedText, prevLen - 5, prevLen)
    end

    e.time = e.time + dt;
    e.charactersDisplayed = self:getCharactersDisplayed(e)

    if(e.prevTextLen < e.charactersDisplayed) then
        Signal.emit('talk');
        e.prevTextLen = e.charactersDisplayed
    end

    self:printText(e, e.charactersDisplayed)
end

return TextSystem
