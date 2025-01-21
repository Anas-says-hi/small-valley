require "utils"
local EntityManager = require "Entity"
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
