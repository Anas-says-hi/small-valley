local Items = require "Items"
local EntityManager = require "Entity"
require "Collider"
-- require "Player"

function SpawnItem(tb)
    local item = Items[tb.name]
    local entity = {
        name = tb.name,
        pos = tb.pos,
        sprite = item.tool.sprite,
        transitionType = "stay",
    }

    EntityManager.addEntity(entity)
    return entity
end
