require "ItemEntity"

function Crop(tb, soil)
    local states = { "planted", "growing", "grown" }

    return {
        name = tb.name or "Crop",
        pos = tb.pos or vec2(0, 0),
        sprite = tb.sprite or sprite("assets/Planted_wheat.png"),
        state = states[1],
        stateIndex = 1,
        drop = tb.drop,
        stateSprites = tb.stateSprites,
        speed = tb.speed or 2,
        lifespan = nil,
        update = function(self, runningTime)
            if not self.lifespan and string.find(soil.state, "watered") then
                self.lifespan = runningTime + self.speed
            end
            if self.lifespan then
                if love.timer.getTime() >= self.lifespan and self.stateIndex <= 2 then
                    self.stateIndex = self.stateIndex + 1
                    self.state = states[self.stateIndex]
                    self.lifespan = love.timer.getTime() + self.speed
                end
            end
        end,
        dropItem = function(self)
            SpawnItem({
                name = self.drop,
                pos = self.pos,
            })
        end,
        draw = function(self, pos)
            self.pos = pos
            love.graphics.draw(self.stateSprites[self.state], pos.x, pos.y)
        end
    }
end
