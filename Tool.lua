function Tool(tb)
    tb = tb or {}
    return {
        name = tb.name or "Item",
        sprite = tb.sprite or sprite("Hoe.png"),
        pos = tb.pos or vec2(100, 100),
        type = tb.type or "misc",
        selected = false,
        update = function(self, targetPos)
            self.pos = add(targetPos, vec2(10, 3))
        end,
        draw = function(self)
            love.graphics.draw(self.sprite, self.pos.x, self.pos.y)
        end
    }
end
