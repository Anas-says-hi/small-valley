require "utils"

local CamPos = vec2(0, 0)

function Camera(tb)
    return {
        followPos = vec2(100, 100),
        camPos = vec2(0, 0),
        smoothing = 0.1,
        follow = function(self, pos, dt)
            self.followPos = pos
            local targetX = -self.followPos.x + love.graphics.getWidth() / 8 - 5
            local targetY = -self.followPos.y + love.graphics.getHeight() / 8 - 5

            self.camPos.x = self.camPos.x + (targetX - self.camPos.x) * self.smoothing
            self.camPos.y = self.camPos.y + (targetY - self.camPos.y) * self.smoothing
            setCamPos(self.camPos)
        end,
        record = function(self)
            love.graphics.translate(self.camPos.x, self.camPos.y)
        end,
        stop = function(self)
            love.graphics.translate(self.camPos.x * -1, self.camPos.y * -1)
        end
    }
end

return CamPos
