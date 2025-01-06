require "utlis"
require("Collider")
function Player(tb)
    if not tb then tb = {} end
    return {
        pos = tb.pos or vec2(0, 0),
        sprite = Animation({ "assets/Player.png", "assets/Player_2.png" }),
        dir = vec2(0, 1),
        currSpeed = 0,
        toolInUse = nil,
        size = vec2(10, 10),
        -- collider = { pos = tb.pos, size = vec2(10, 10) }
        speed = tb.speed or 2,
        collders = getColliders(),
        update = function(self, dt, parms)
            self.colliders = getColliders()
            self.toolInUse = parms.holdingItem

            self.dir = vec2(0, 0)
            self.currSpeed = 0

            if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
                self.dir.y = 1
                self.currSpeed = self.speed
            end
            if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
                self.dir.y = -1
                self.currSpeed = self.speed
            end
            if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
                self.dir.x = -1
                self.currSpeed = self.speed
            end
            if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
                self.dir.x = 1
                self.currSpeed = self.speed
            end

            if self.toolInUse then
                self.toolInUse.tool.pos = add(self.pos, vec2(10, 0))
            end

            local newPos = add(self.pos, mult(mult(self.dir, self.currSpeed), dt))

            -- self.collider = {
            --     pos = pos
            -- }

            for i, collider in pairs(self.colliders) do
                if rectCollision(vec2(newPos.x, self.pos.y + 4), collider.pos, vec2(self.size.x, self.size.y - 4), collider.size) then
                    if self.dir.x > 0 then
                        newPos.x = collider.pos.x - self.size.x
                    elseif self.dir.x < 0 then
                        newPos.x = collider.pos.x + collider.size.x
                    end
                end
                if rectCollision(vec2(self.pos.x, newPos.y + 4), collider.pos, vec2(self.size.x, self.size.y - 4), collider.size) then
                    if self.dir.y > 0 then
                        newPos.y = collider.pos.y - self.size.y
                    elseif self.dir.y < 0 then
                        newPos.y = collider.pos.y + collider.size.y - 4
                    end
                end
            end


            self.pos = newPos

            self.sprite:update()
        end,
        draw = function(self)
            self.sprite:draw(self.pos)
            if self.toolInUse then
                self.toolInUse.tool:draw()
            end
        end
    }
end
