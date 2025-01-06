require "utlis"
require "anim"
require("Crops")
require("Resources")

function Cell(tb)
    local rand = math.random(0, 10)
    local stateSprites = {
        plain = Animation({ "assets/Grass/Grass.png" }),
        tilled = Animation({ "assets/Tilled.png" }),
        watered = Animation({ "assets/Watered.png" })
    }
    return {
        pos = tb.pos or vec2(100, 100),
        size = vec2(8, 8),
        interactable = false,
        playerPos = tb.playerPos or vec2(0, 0),
        inReach = false,
        state = "plain",
        resource = tb.resource,
        crop = nil,
        randomFlip = randomVec2(),
        randomness = rand >= 1 and "none" or "X",

        sprite = rand >= 1 and stateSprites.plain or
            stateSprites.grass,
        update = function(self, dt, parms)
            local usingTool = parms.tool
            if distance(parms.playerPos, self.pos) < 24 then
                self.inReach = true
            else
                self.inReach = false
            end


            if rectCollision(self.pos, getMousePos(), self.size, nil) and self.inReach then
                self.interactable = true
            else
                self.interactable = false
            end

            if string.find(self.state, "tilled") then
                self.sprite = stateSprites.tilled
            end

            if self.state == "plain" then
                self.sprite = stateSprites.plain
            end

            if string.find(self.state, "watered") then
                self.sprite = stateSprites.watered
            end

            self.sprite:update()

            if self.crop then
                self.crop:update(parms.runningTime)
            end

            if self.resource then
                self.resource:update()
            end
        end,
        interact = function(self, tool)
            if self.interactable then
                tool:onUse(self)
            end
        end,
        plantCrop = function(self, crop)
            self.crop = NewCrop(crop, self)
            -- self.state = "tilled_planted"
        end,
        draw = function(self)
            if self.randomness == "none" then
                self.sprite:draw(self.pos)
            elseif self.randomness == "XY" then
                self.sprite:draw(self.pos, self.randomFlip)
            elseif self.randomness == "X" then
                self.sprite:draw(self.pos, vec2(self.randomFlip.x, 1))
            elseif self.randomness == "Y" then
                self.sprite:draw(self.pos, vec2(1, self.randomFlip.y))
            end
            if self.interactable then
                love.graphics.setColor({ 1, 1, 1 })
            else
                love.graphics.setColor({ 0, 0, 0, 0 })
            end

            if self.inReach then
                love.graphics.setLineWidth = 1
                love.graphics.rectangle("line", self.pos.x + 1, self.pos.y + 1, self.size.x - 2, self.size.y - 2)
                love.graphics.setLineWidth = 1
            end

            love.graphics.setColor(1, 1, 1)
            if self.crop then
                self.crop:draw(add(self.pos, vec2(0, -1)))
            end

            if self.resource then
                self.resource:draw(self.pos)
            end
        end
    }
end

function randomVec2()
    local x = math.random(0, 1) * 2 - 1
    local y = math.random(0, 1) * 2 - 1

    return vec2(x, y)
end
