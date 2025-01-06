require "anim"
require "Tool"

function Seed(tb)
    return {
        crop = tb.crop or "wheat",
        tool = Tool({
            name = tb.name,
            sprite = sprite(tb.sprite),
            type = "seed",
        }),
        onUse = function(self, cell)
            if string.find(cell.state, "tilled") and not cell.crop then
                cell:plantCrop(self.crop)
            end
        end,
        update = function(self, targetPos)
            self.tool:update(targetPos)
        end
    }
end
