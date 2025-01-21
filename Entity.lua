require "utils"

local EntityManager = {}
EntityManager.entities = {}

function EntityManager.addEntity(tb)
    local entity = {
        name = tb.name or "entity",
        sprite = tb.sprite,
        pos = tb.pos or vec2(0, 0),
        dead = false,
        opacity = 1.0,
        transitionType = tb.transitionType or "none",
        transition = tb.transition or true,
        lifespan = tb.transitionType == "stay" and love.timer.getTime() + 20 or love.timer.getTime() + 2,
        rotation = 0,
        update = function(self)
            if self.lifespan <= love.timer.getTime() and self.transitionType ~= "stay" then
                self.dead = true
            end

            if self.transition == true then
                if self.transitionType == "none" then
                    self.opacity = self.opacity - 0.01
                elseif self.transitionType == "stay" then
                    self.pos.y = self.pos.y + math.sin(love.timer.getTime()) * 0.06
                elseif self.transitionType == "fall" then
                    self.rotation = self.rotation - 0.02
                    self.opacity = self.opacity - 0.02
                    self.pos.y = self.pos.y + 0.1
                end
            end
        end,
        draw = function(self)
            love.graphics.setColor({ 1, 1, 1, self.opacity })
            love.graphics.draw(self.sprite, self.pos.x + self.sprite:getWidth() / 2, self.pos.y + self.sprite:getHeight(),
                self.rotation, 1, 1,
                self.sprite:getWidth() / 2,
                self.sprite:getHeight())
            love.graphics.setColor({ 1, 1, 1, 1 })
        end
    }

    table.insert(EntityManager.entities, entity)
end

function EntityManager:update()
    for i = #self.entities, 1, -1 do
        local entity = self.entities[i]
        entity:update()
        if entity.dead then
            table.remove(self.entities, i)
        end
    end
end

function EntityManager:draw()
    for i, entity in pairs(self.entities) do
        entity:draw()
    end
end

return EntityManager
