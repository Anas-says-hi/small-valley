Items = require "Items"
function Inventory()
    return {
        items = {},
        slotSprite = sprite("assets/Inven_slot.png"),
        selectedItem = nil,
        pressed = false,
        addItem = function(self, itemName)
            table.insert(self.items, Items[itemName])
        end,
        selectItem = function(self)
            for i, item in pairs(self.items) do
                if rectCollision(getMousePos(), vec2(i * 12 - 12, 0), vec2(0, 0), vec2(13, 13)) then
                    for i, itm in pairs(self.items) do
                        itm.tool.selected = false
                    end
                    item.tool.selected = true
                    self.selectedItem = item
                end
            end
        end,
        update = function(self)
            if self.selectedItem == nil then
                self.items[1].tool.selected = true
                self.selectedItem = self.items[1]
            end
        end,
        draw = function(self)
            for i, item in pairs(self.items) do
                love.graphics.draw(self.slotSprite, i * 12 - 12, 0)
                love.graphics.draw(item.tool.sprite, i * 12 - 10, 2)
                if item.tool.selected then
                    love.graphics.rectangle("line", i * 12 - 11, 1, 10, 10)
                end
            end
        end
    }
end
