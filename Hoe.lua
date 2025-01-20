require "Tool"

function Hoe()
    return {
        tool = Tool({
            name = "Hoe",
            sprite = sprite("assets/Hoe.png"),
            type = "hoe",
        }),
        onUse = function(self, cell)
            if cell.crop then
                cell.crop = nil
            elseif cell.state == "plain" and not cell.resource then
                cell.state = "tilled"
                cell.randomness = "XY"
            end
        end,
        update = function(self, targetPos)
            self.tool:update(targetPos)
        end
    }
end
