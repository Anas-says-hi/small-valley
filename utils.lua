GRAPHICS_SCALE = 4

function mult(v1, v2)
    if type(v1) == "number" then
        return {
            x = v1.x * v2,
            y = v1.y * v2
        }
    elseif type(v2) == "number" then
        return {
            x = v1.x * v2,
            y = v1.y * v2
        }
    else
        return {
            x = v1.x * v2.x,
            y = v2.y * v1.y
        }
    end
end

function add(v1, v2)
    if type(v1) == "number" then
        return {
            x = v1.x + v2,
            y = v1.y + v2
        }
    elseif type(v2) == "number" then
        return {
            x = v1.x + v2,
            y = v1.y + v2
        }
    else
        return {
            x = v1.x + v2.x,
            y = v2.y + v1.y
        }
    end
end

function substract(v1, v2)
    if type(v1) == "number" then
        return {
            x = v1.x - v2,
            y = v1.y - v2
        }
    elseif type(v2) == "number" then
        return {
            x = v1.x - v2,
            y = v1.y - v2
        }
    else
        return {
            x = v1.x - v2.x,
            y = v1.y - v2.y
        }
    end
end

function vec2(x, y)
    return {
        x = x,
        y = y
    }
end

function getMousePos()
    return vec2(love.mouse.getX() / GRAPHICS_SCALE, love.mouse.getY() / GRAPHICS_SCALE)
end

local camPos = vec2(0, 0)

function getWorldPos()
    local mp = vec2(getMousePos().x - camPos.x, getMousePos().y - camPos.y)
    return mp
end

function setCamPos(cp)
    camPos = cp
end

function distance(vec1, vec2)
    return math.sqrt((vec2.x - vec1.x) ^ 2 + (vec2.y - vec1.y) ^ 2)
end

function mag(vec)
    return math.sqrt(vec.x ^ 2 + vec.y ^ 2)
end

function rectCollision(pos1, pos2, size1, size2)
    size1 = size1 or { x = 0, y = 0 }
    size2 = size2 or { x = 0, y = 0 }

    return pos1.x < pos2.x + size2.x and
        pos1.x + size1.x > pos2.x and
        pos1.y < pos2.y + size2.y and
        pos1.y + size1.y > pos2.y
end

function normalize(v2)
    local magnitude = mag(v2)
    if magnitude == 0 then
        return vec2(1, 0)
    end
    return vec2(v2.x / magnitude, v2.y / magnitude)
end

function sprite(path)
    return love.graphics.newImage(path)
end

function split(pString, pPattern)
    local Table = {}
    local fpat = "(.-)" .. pPattern
    local last_end = 1
    local s, e, cap = pString:find(fpat, 1)
    while s do
        if s ~= 1 or cap ~= "" then
            table.insert(Table, cap)
        end
        last_end = e + 1
        s, e, cap = pString:find(fpat, last_end)
    end
    if last_end <= #pString then
        cap = pString:sub(last_end)
        table.insert(Table, cap)
    end
    return Table
end

function drawLabel(text, pos, scale)
    scale = scale or 1
    pos = pos or vec2(0,0)
    local padding = 2
    local text = love.graphics.newText(love.graphics.getFont(), string.upper(text))
    love.graphics.setColor(0.1, 0.1, 0.1, 1)
    love.graphics.rectangle("fill", pos.x - padding, pos.y - padding, text:getWidth() + padding,
        text:getHeight() + padding, 0)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(text, pos.x - padding / 2, pos.y - padding / 2, 0, scale)
end

function rgb(color)
    return { color[1] / 256, color[2] / 256, color[3] / 256, color[4] and color[4] / 256 or 1.0 }
end

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end
