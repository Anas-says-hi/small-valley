require "anim"
require "Tool"

function Hoe()
    return {
        tool = Tool({
            name = "Hoe",
            sprite = sprite("assets/Hoe.png"),
            type = "hoe",
        }),
        onUse = function(self, cell)
            if not cell.resource then
                if cell.crop then
                    cell.crop = nil
                elseif cell.state == "plain" then
                    cell.state = "tilled"
                    cell.randomness = "XY"
                end
            else
                cell.resource = nil
            end
        end,
        update = function(self, targetPos)
            self.tool:update(targetPos)
        end
    }
end
