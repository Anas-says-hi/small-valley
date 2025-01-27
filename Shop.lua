local Items = require "Items"
local Inventory = require "Inventory"
local Shop = {}
Shop.items = {}
Shop.active = false
Shop.width = 160
Shop.height = 100
Shop.state = "Buy"
Shop.player = nil

local w, h = love.window.getMode()

function Shop:update(dt)
    Shop.pressed = false
    if self.active and self.player then
        self.player.locked = true
    else
        self.player.locked = false
    end
end

function Shop:onClick()
    local pos = vec2(w / 8 - self.width / 2, h / 8 - self.height / 2)

    if rectCollision(getMousePos(), add(pos, vec2(2, 0)), vec2(1, 1), vec2(16, 6)) then
        self.state = "Buy"
    end
    if rectCollision(getMousePos(), add(pos, vec2(22, 0)), vec2(1, 1), vec2(21, 6)) then
        self.state = "Sell"
    end

    local i = 0
    if self.state == "Buy" then
        for _, item in pairs(Items) do
            if item.buyable then
                i = i + 1
                local tw = love.graphics.newText(love.graphics.getFont(), "BUY $" .. string.upper(item.price)):getWidth()

                if rectCollision(getMousePos(), vec2(pos.x + self.width - tw - 5, pos.y + i * 10 + 3 - 12 + 10), vec2(1, 1), vec2(tw + 5, 6)) then
                    if self.player.money >= item.price then
                        Inventory:addItem(item.id)
                        self.player.money = self.player.money - item.price
                    end
                end
            end
        end
    else
        local i = 0
        for j, item in pairs(Inventory.items) do
            local item = item.item
            if item.sellable then
                i = i + 1
                local tw = love.graphics.newText(love.graphics.getFont(), "SELL $" .. string.upper(item.price)):getWidth()
                if rectCollision(getMousePos(), vec2(pos.x + self.width - tw - 4, pos.y + i * 10 + 3 - 12 + 10), vec2(1, 1), vec2(tw + 2, 6)) then
                    Inventory:removeItem(string.lower(item.tool.name))
                    self.player.money = self.player.money + item.price
                end
            end
        end
    end
end

function Shop:draw()
    local pos = vec2(w / 8 - self.width / 2, h / 8 - self.height / 2)
    love.graphics.rectangle("fill", pos.x, pos.y - 2, self.width, self.height + 10)

    if self.state == "Buy" then
        drawLabel("buy", add(pos, vec2(4, 2)))
        drawLabel("sell", add(pos, vec2(24, 2)), 2, 1, false, { 0.7, 0.7, 0.7 })
    else
        drawLabel("buy", add(pos, vec2(4, 2)), 2, 1, false, { 0.7, 0.7, 0.7 })
        drawLabel("sell", add(pos, vec2(24, 2)))
    end


    if self.state == "Buy" then
        local i = 0
        for _, item in pairs(Items) do
            if item.buyable then
                i = i + 1
                love.graphics.draw(item.tool.sprite, pos.x + 2, pos.y + i * 10)
                local len = 14
                local ext = #item.tool.name > len and "..." or ""
                drawLabel(limitString(item.tool.name, len) .. ext, vec2(pos.x + 14, pos.y + i * 10 + 3), 2, 1, true,
                    { 0, 0, 0, 1 })
                local tw = love.graphics.newText(love.graphics.getFont(), string.upper(item.price)):getWidth()
                drawLabel("BUY $" .. item.price, vec2(pos.x + self.width - tw - 25, pos.y + i * 10 + 3), 2, 1)
            end
        end
    else
        local i = 0
        for j, item in pairs(Inventory.items) do
            local item = item.item
            if item.sellable then
                i = i + 1
                love.graphics.draw(item.tool.sprite, pos.x + 2, pos.y + i * 10)
                local len = 14
                local ext = #item.tool.name > len and "..." or ""
                drawLabel(limitString(item.tool.name, len) .. ext, vec2(pos.x + 14, pos.y + i * 10 + 3), 2, 1, true,
                    { 0, 0, 0, 1 })
                local tw = love.graphics.newText(love.graphics.getFont(), "SELL $" .. string.upper(item.price)):getWidth()
                drawLabel("SELL $" .. item.price, vec2(pos.x + self.width - tw - 2, pos.y + i * 10 + 3), 2, 1)
            end
        end
    end
end

return Shop
