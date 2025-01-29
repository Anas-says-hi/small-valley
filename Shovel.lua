require "Tool"
local EntityManager = require "Entity"
function Shovel()
    return {
        tool = Tool({
            name = "Shovel",
            sprite = sprite("assets/Shovel.png"),
            type = "shovel",
        }),
        onUse = function(self, cell)
            if cell.state ~= "plain" then
                cell.state = "plain"
                cell.randomness = "XY"
            end

            if cell.resource and cell.resource.type == "rock" then
                EntityManager.addEntity({
                    sprite = cell.resource.frame_1,
                    transitionType = "fall",
                    pos = add(cell.resource.pos, cell.resource.off)
                })
                cell:removeResource()
            end
        end,
        update = function(self, targetPos)
            self.tool:update(targetPos)
        end
    }
end
