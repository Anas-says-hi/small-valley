require "Tool"

function Item(tb)
    return {
        id = tb.id,
        sellable = tb.sellable or false,
        buyable = tb.buyable or false,
        frame_1 = sprite(tb.sprite),
        price = tb.price or 0,
        tool = Tool({
            name = tb.name,
            sprite = sprite(tb.sprite),
        }),
        onUse = function(self, cell)
            return
        end,
        update = function(self, targetPos)
            self.tool:update(targetPos)
        end
    }
end
