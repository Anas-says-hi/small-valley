require "Tool"

function Item(tb)
    return {
        id = tb.id,
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
