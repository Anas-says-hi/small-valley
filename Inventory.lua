Items = require "Items"

local Inventory = {}
Inventory.items = {}
Inventory.slotSprite = sprite("assets/Inven_slot.png")
Inventory.slotSelectSprite = sprite("assets/Inven_slot_select.png")
Inventory.selectItem = nil
Inventory.selectedItem = nil
Inventory.itemIndex = 1
Inventory.slots = 9
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
    for i = 1, self.slots, 1 do
        if rectCollision(getMousePos(), vec2(i * 13 - 12, 1), vec2(0, 0), vec2(13, 13)) then
            self.itemIndex = i
        end
    end
end

function Inventory:selectItemByIndex(num)
    self.itemIndex = num
end

function Inventory:update()
    self.selectedItem = self.items[self.itemIndex]
    -- if self.selectedItem == nil then
    --     if self.items[1].item then
    --     end
    --     self.selectedItem = self.items[1].item
    -- end
end

function Inventory:draw()
    local labels = {}
    for i = 1, self.slots, 1 do
        local item = self.items[i]
        love.graphics.draw(self.slotSprite, i * 13 - 12, 1)
        if item and item.item then
            love.graphics.draw(item.item.tool.sprite, i * 13 - 9, 4)
            if item.amount > 1 then
                table.insert(labels, {
                    amount = item.amount,
                    pos = vec2((i * 13 - 7), 14)
                })
            end
        end
        if i == self.itemIndex then
            love.graphics.draw(self.slotSelectSprite, i * 13 - 11, 2)
        end
    end

    for i, lbl in pairs(labels) do
        drawLabel(lbl.amount, lbl.pos, 2, 1)
    end

    for i, item in pairs(self.items) do
        if rectCollision(getMousePos(), vec2(i * 13 - 12, 0), vec2(0, 0), vec2(13, 13)) then
            drawLabel(item.item.tool.name, add(getMousePos(), vec2(8, 4)))
        end
    end
end

return Inventory
