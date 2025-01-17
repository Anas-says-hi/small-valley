require "Collider"
require "utlis"
function Resource(tb, pos)
    local rand = math.random(0.2, 1)
    return {
        name = tb.name or "Resource",
        off = tb.pos or vec2(0, 0),
        pos = pos,
        sort = tb.sort or false,
        collider = tb.collider and Collider(add(pos, tb.collider.pos), tb.collider.size) or nil,
        sprite = Animation(tb.sprites, { speed = tb.speed }),
        update = function(self)
            -- print(self.sprite.speed)
            self.sprite:update()
        end,
        draw = function(self)
            -- love.graphics.draw(self.sprite, self.pos.x, self.pos.y)
            self.sprite:draw(add(self.pos, self.off))
        end
    }
end

return Resource
