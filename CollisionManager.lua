function CollisionManager(tb)
    return {
        staticColliders = tb.statics or {},
        dynamicColliders = tb.dynamics or {},
        update = function(self)

        end,
        draw = function(self)
            for i, val in pairs(self.dynamicColliders) do
                love.graphics.rectangle("line", val.pos.x, val.pos.y, val.size.x, val.size.y)
            end
        end
    }
end
