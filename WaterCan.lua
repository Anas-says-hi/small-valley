require "anim"
require "Tool"

function WaterCan()
    return {
        tool = Tool({
            name = "Watering Can",
            sprite = sprite("assets/Water_can.png"),
            type = "watering_can"
        }),
        onUse = function(self, cell)
            if cell.state == "tilled" then
                cell.state = "tilled_watered"
                cell.randomness = "XY"
            end
        end,
        update = function(self, targetPos)
            self.tool:update(targetPos)
        end
    }
end
