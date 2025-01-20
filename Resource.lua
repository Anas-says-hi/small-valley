require "Collider"
require "utils"
function Resource(tb, pos)
    local rand = math.random(0.2, 1)
    return {
        name = tb.name or "Resource",
        off = tb.pos or vec2(0, 0),
        pos = pos,
        size = tb.size or vec2(8, 8),
        sort = tb.sort or false,
        collider = tb.collider and Collider(add(pos, tb.collider.pos), tb.collider.size) or nil,
        frame_1 = sprite(tb.sprites[1]),
        sprite = Animation(tb.sprites, { speed = tb.speed }),
        update = function(self)
            -- print(self.sprite.speed)
            self.sprite:update()
        end,
        draw = function(self)
            --self.pos = add(self.pos, self.off)
            self.sprite:draw(add(self.pos, self.off))
        end
    }
end

return Resource
