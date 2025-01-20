require "utils"

local CamPos = vec2(0, 0)

function Camera(tb)
    return {
        followPos = vec2(100, 100),
        camPos = vec2(0, 0),
        follow = function(self, pos)
            self.followPos = pos
            self.camPos = vec2(-self.followPos.x + love.graphics:getWidth() / 8 - 5,
                -self.followPos.y + love.graphics:getHeight() / 8 - 5)

            print(self.camPos)
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
