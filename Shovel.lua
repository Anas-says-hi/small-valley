require "Tool"

function Shovel()
    return {
        tool = Tool({
            name = "Shovel",
            sprite = sprite("assets/Shovel.png"),
            type = "shovel",
        }),
        onUse = function(self, cell)
            if cell.crop then
                cell.crop:dropItem()
                cell.crop = nil
            elseif cell.state ~= "plain"then
                cell.state = "plain"
                cell.randomness = "XY"
            end
        end,
        update = function(self, targetPos)
            self.tool:update(targetPos)
        end
    }
end
