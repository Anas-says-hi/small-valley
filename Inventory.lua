Items = require "Items"

local Inventory = {}
Inventory.items = {}
Inventory.slotSprite = sprite("assets/Inven_slot.png")
Inventory.selectItem = nil
Inventory.selectedItem = nil
Inventory.itemIndex = 1

function Inventory:addItem(itemName, amount)
    amount = amount or 1
    local itm = {
        item = Items[itemName],
        amount = amount
    }
    local alreadyExists = false
    for i, item in pairs(self.items) do
        if item.item.tool.name == Items[itemName].tool.name then
            item.amount = item.amount + amount
            alreadyExists = true
        end
    end
    if not alreadyExists then
        table.insert(self.items, itm)
    end
end

function Inventory:removeItem(itemName)
    local alreadyExists = false
    for i, item in pairs(self.items) do
        if Items[itemName] and item.item.tool.name == Items[itemName].tool.name then
            if item.amount > 1 then
                item.amount = item.amount - 1
            else
                table.remove(self.items, i)
            end
        end
    end
end

function Inventory:selectItem()
    for i, item in pairs(self.items) do
        if rectCollision(getMousePos(), vec2(i * 12 - 12, 0), vec2(0, 0), vec2(13, 13)) then
            for i, itm in pairs(self.items) do
                itm.item.tool.selected = false
            end
            item.item.tool.selected = true
            self.selectedItem = item.item
            self.itemIndex = i
        end
    end
end

function Inventory:selectItemByIndex(num)
    if num <= #self.items then
        for i, itm in pairs(self.items) do
            itm.item.tool.selected = false
        end
        self.itemIndex = num
        self.selectedItem = self.items[num].item
        self.items[num].item.tool.selected = true
    end
end

function Inventory:update()
    if self.selectedItem == nil then
        self.items[1].item.tool.selected = true
        self.selectedItem = self.items[1].item
    end
end

function Inventory:draw()
    local labels = {}
    for i, item in pairs(self.items) do
        love.graphics.draw(self.slotSprite, i * 12 - 12, 0)
        love.graphics.draw(item.item.tool.sprite, i * 12 - 10, 2)
        if item.amount > 1 then
            table.insert(labels, {
                amount = item.amount,
                pos = vec2(i * 13 - 13, 10)
            })
        end
        if item.item.tool.selected then
            love.graphics.rectangle("line", i * 12 - 11, 1, 10, 10)
        end
    end

    for i, lbl in pairs(labels) do
        drawLabel(lbl.amount, lbl.pos)
    end

    for i, item in pairs(self.items) do
        if rectCollision(getMousePos(), vec2(i * 12 - 12, 0), vec2(0, 0), vec2(13, 13)) then
            drawLabel(item.item.tool.name, add(getMousePos(), vec2(8,4)))
        end
    end
end

return Inventory
