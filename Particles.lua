require "utlis"

function Particles()
    local parts = {}
    for i = 1, 100, 1 do
        table.insert(parts, {
            pos = vec2(0, 0),
            speed = 10,
            dir = vec2(math.random() * math.random(-1, 1), math.random() * math.random(-1, 1))
        })
    end
    return {
        particles = parts,
        update = function(self)
            for i, part in pairs(self.particles) do
                part.pos.x = part.pos.x + part.speed * part.dir.x
                part.pos.y = part.pos.y + part.speed * part.dir.y
            end
        end,
        draw = function(self)
            for i, part in pairs(self.particles) do
                love.graphics.rectangle("fill", part.pos.x + 100, part.pos.y + 100, 2, 2)
            end
        end
    }
end
