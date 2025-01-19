require "utils"

function newParticle(tb)
    local parts = {}
    local gravity = tb.gravity or false
    local pos = tb.pos
    local speed = tb.speed or 12
    local size = tb.size or 2
    local num = tb.num or 10
    local color = tb.color and { tb.color[1], tb.color[2], tb.color[3], tb.color[4] and tb.color[4] or 1.0 } or
        { 1.0, 1.0, 1.0, 1 }
    local lifespan = tb.lifespan or love.timer.getTime() + 1
    for i = 1, num do
        local dir = vec2(math.random(-100, 100) / 100, math.random(-100, 100) / 100)

        if dir.x == 0 and dir.y == 0 then
            dir.x = 1
        end

        dir = normalize(dir)

        table.insert(parts, {
            pos = { x = gravity and pos.x + math.random(-3, 3) or pos.x, y = gravity and pos.y + math.random(-3, 3) or pos.y },
            speed = speed,
            lifespan = lifespan + 2,
            radius = size,
            dir = dir,
            color = color
        })
    end

    return parts
end

function Particles(tb)
    return {
        particles = newParticle(tb),
        currTime = love.timer.getTime(),
        ended = false,
        fade = tb.fade or false,
        gravity = tb.gravity or false,
        update = function(self, dt)
            for i = #self.particles, 1, -1 do
                local part = self.particles[i]

                if love.timer.getTime() >= part.lifespan then
                    table.remove(self.particles, i)
                else
                    if self.fade then
                        if part.color[4] > 0 then
                            part.color[4] = part.color[4] - 0.01
                        end
                    else
                        if part.radius > 0 then
                            part.radius = part.radius - 0.1
                        end
                    end
                    if tb.gravity then
                        part.pos.y = part.pos.y + part.speed * dt
                    else
                        part.pos.x = part.pos.x + part.speed * part.dir.x * dt
                        part.pos.y = part.pos.y + part.speed * part.dir.y * dt
                    end
                end
            end

            if #self.particles == 0 then
                self.ended = true
            end
        end,
        draw = function(self)
            for i, part in pairs(self.particles) do
                love.graphics.setColor(part.color)
                love.graphics.circle("fill", part.pos.x, part.pos.y, part.radius)
            end
            love.graphics.setColor(1, 1, 1, 1)
        end
    }
end
