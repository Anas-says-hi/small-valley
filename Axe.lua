require "Tool"

function Axe()
    return {
        tool = Tool({
            name = "Axe",
            sprite = sprite("assets/Axe.png"),
            type = "axe",
        }),
        onUse = function(self, cell)
            if cell.resource then
                cell:removeResource()
            end
        end,
        update = function(self, targetPos)
            self.tool:update(targetPos)
        end
    }
end
