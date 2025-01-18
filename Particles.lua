require "utlis"

function newParticle(tb)
    local parts = {}
    local pos = tb.pos
    for i = 1, 20 do
        -- Generate a random direction
        local dir = vec2(math.random(-100, 100) / 100, math.random(-100, 100) / 100)

        if dir.x == 0 and dir.y == 0 then
            dir.x = 1
        end

        dir = normalize(dir)

        table.insert(parts, {
            pos = { x = pos.x, y = pos.y }, -- Ensure a unique position table
            speed = 12,
            lifespan = love.timer.getTime() + math.random(0.2, 0.4),
            radius = 2,
            dir = dir
        })
    end
    return parts
end


function Particles(tb)
    return {
        particles = newParticle(tb),
        currTime = love.timer.getTime(),
        ended = false,
        update = function(self, dt)
            for i, part in pairs(self.particles) do
                if love.timer.getTime() >= part.lifespan then
                    -- self.ended = true
                    table.remove(self.particles, i)
                end
                if part.radius > 0 then
                part.radius = part.radius - 0.1
                end
                part.pos.x = part.pos.x + part.speed * part.dir.x * dt
                part.pos.y = part.pos.y + part.speed * part.dir.y * dt
            end
        end,
        draw = function(self)
            for i, part in pairs(self.particles) do
                love.graphics.circle("fill", part.pos.x, part.pos.y, part.radius)
            end
        end
    }
end
