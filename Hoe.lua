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
                if cell.crop.stateIndex == 3 then
                    if cell.crop.regrowable then
                        cell.crop.stateIndex = 1
                        cell.crop:dropItem()
                    else
                        cell.crop:dropItem()
                        cell.crop = nil
                    end
                else
                    cell.crop = nil
                end
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
