require "Particles"
local Particle = {}
Particle.particles = {}

function Particle.newParticle(tb)
    local part = Particles(tb)
    table.insert(Particle.particles, part)

    return Particle.particles
end

function Particle:update(dt)
    for i, part in pairs(self.particles) do
        if part.ended then
            table.remove(self.particles, i)
        end
        part:update(dt)
    end
end

function Particle:draw(tb)
    for i, part in pairs(self.particles) do
        part:draw()
    end
end

return Particle
