require "Collider"
require "utils"
require "ItemEntity"
function Resource(tb, pos)
    local rand = math.random(0.2, 1)
    return {
        name = tb.name or "Resource",
        off = tb.pos or vec2(0, 0),
        pos = pos,
        size = tb.size or vec2(8, 8),
        sort = tb.sort or false,
        type = tb.type or "generic",
        dropItem = tb.drop or nil,
        destructable = tb.destructable,
        collider = tb.collider and Collider(add(pos, tb.collider.pos), tb.collider.size, tb.collider.id or nil) or nil,
        frame_1 = sprite(tb.sprites[1]),
        sprite = Animation(tb.sprites, { speed = tb.speed }),
        destroy = function(self)
            if self.collider then
                self.collider:remove()
            end

            if self.dropItem then
                SpawnItem({
                    name = self.dropItem,
                    pos = add(self.pos, self.off)
                })
            end
        end,
        update = function(self)
            self.sprite:update()
        end,
        draw = function(self)
            self.sprite:draw(add(self.pos, self.off))
        end
    }
end

return Resource
