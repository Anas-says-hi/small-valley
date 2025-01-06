require("Resource")

local Resources = {
    grass = {
        name = "Grass",
        sprites = { "assets/Grass.png", "assets/Grass_2.png" },
        pos = vec2(0, 0),
    },
    rock = {
        name = "Rock",
        sprites = { "assets/Rock.png" },
        pos = vec2(0, 0),
        collider = { pos = vec2(0, 0), size = vec2(5, 5) },
    },
    tree = {
        name = "Tree",
        sprites = { "assets/Tree.png" },
        collider = { pos = vec2(0, 0), size = vec2(8, 8) },
        pos = vec2(0, -8)
    },
    bush = {
        name = "bush",
        sprites = { "assets/Bush.png" },
    }
}



function NewResource(res, pos)
    pos = pos or vec2(0, 0)
    local tb = Resources[res]
    tb.speed = math.random(0.3, 0.6)
    return Resource(tb, pos)
end
