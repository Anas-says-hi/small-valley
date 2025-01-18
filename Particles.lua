require "utlis"

function Particles()
    local parts = {}
    for i = 1, 100, 1 do
        table.insert(parts, {
            pos = vec2(0, 0),
            speed = 1,
            lifespan = love.timer.getTime() + 0.2,
            radius = 0.4 + math.random(-0.2, 0.3),
            dir = normalize(vec2(math.random() * math.random(-1, 1), math.random() * math.random(-1, 1)))
        })
    end
    return {
        particles = parts,
        currTime = love.timer.getTime(),
        update = function(self)
            for i, part in pairs(self.particles) do
                if part.lifespan <= love.timer.getTime() then
                    table.remove(self.particles, i)
                    -- part.lifespan = love.timer.getTime() + 2
                end
                part.pos.x = part.pos.x + part.speed * part.dir.x
                part.pos.y = part.pos.y + part.speed * part.dir.y
            end
        end,
        draw = function(self)
            for i, part in pairs(self.particles) do
                love.graphics.circle("fill", part.pos.x + 100, part.pos.y + 100, part.radius)
            end
        end
    }
end
