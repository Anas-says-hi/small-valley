require "utils"

function Animation(frms, options)
    local tb = {}
    for i = 1, #frms, 1 do
        table.insert(tb, love.graphics.newImage(frms[i]))
    end

    options = options or {}
    return {
        frames = tb,
        speed = options.speed or 0.4,
        currTime = options.speed or 0.4,
        currFrame = 1,
        update = function(self)
            if #self.frames > 1 then
                if love.timer.getTime() >= self.currTime then
                    if self.currFrame >= #self.frames then
                        self.currFrame = 1
                    else
                        self.currFrame = self.currFrame + 1
                    end
                    self.currTime = self.currTime + self.speed
                end
            end
        end,
        draw = function(self, pos, scale)
            scale = scale or vec2(1, 1)
            local sprite = self.frames[self.currFrame]
            local spriteWidth = sprite:getWidth()
            local spriteHeight = sprite:getHeight()

            local adjustedX = pos.x + (spriteWidth * (1 - scale.x)) / 2
            local adjustedY = pos.y + (spriteHeight * (1 - scale.y)) / 2

            love.graphics.draw(sprite, adjustedX, adjustedY, 0, scale.x, scale.y)
        end
    }
end
