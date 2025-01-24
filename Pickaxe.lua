require "utils"
local EntityManager = require "Entity"
require "Tool"

function Pickaxe()
    return {
        tool = Tool({
            name = "Pickaxe",
            sprite = sprite("assets/Pickaxe.png"),
            type = "pickaxe",
        }),
        onUse = function(self, cell)
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
