function Tool(tb)
    tb = tb or {}
    return {
        name = tb.name or "Item",
        sprite = tb.sprite or sprite("Hoe.png"),
        pos = tb.pos or vec2(100, 100),
        type = tb.type or "misc",
        scale = 1,
        flipX = function(self, flip)
            if flip then
                self.scale = -1
            else
                self.scale = 1
            end
        end,
        update = function(self, targetPos)
            self.pos = add(targetPos, vec2(10, 3))
        end,
        draw = function(self)
            love.graphics.draw(self.sprite, self.pos.x - (self.scale == -1 and -self.sprite:getWidth() or 0), self.pos.y,
                0,
                self.scale,
                1)
        end
    }
end
