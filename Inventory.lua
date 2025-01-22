Items = require "Items"

local Inventory = {}
Inventory.items = {}
Inventory.slotSprite = sprite("assets/Inven_slot.png")
Inventory.selectItem = nil


function Inventory:addItem(itemName)
    for i, item in pairs(self.items) do

    end
    table.insert(self.items, Items[itemName])
end

function Inventory:selectItem()
    for i, item in pairs(self.items) do
        if rectCollision(getMousePos(), vec2(i * 12 - 12, 0), vec2(0, 0), vec2(13, 13)) then
            for i, itm in pairs(self.items) do
                itm.tool.selected = false
            end
            item.tool.selected = true
            self.selectedItem = item
        end
    end
end

function Inventory:update()
    if self.selectedItem == nil then
        self.items[1].tool.selected = true
        self.selectedItem = self.items[1]
    end
end

function Inventory:draw()
    for i, item in pairs(self.items) do
        love.graphics.draw(self.slotSprite, i * 12 - 12, 0)
        love.graphics.draw(item.tool.sprite, i * 12 - 10, 2)
        if item.tool.selected then
            love.graphics.rectangle("line", i * 12 - 11, 1, 10, 10)
        end
    end

    for i, item in pairs(self.items) do
        if rectCollision(getMousePos(), vec2(i * 12 - 12, 0), vec2(0, 0), vec2(13, 13)) then
            drawLabel(item.tool.name, getMousePos())
        end
    end
end

return Inventory

-- function Inventory()
--     return {
--         items = {},
--         selectedItem = nil,
--         pressed = false,
--         addItem = function(self, itemName)
--         end,
--         selectItem = function(self)

--         end,
--         update = function(self)

--         end,
--         draw = function(self)

--         end
--     }
-- end
