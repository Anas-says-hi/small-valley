require("Resource")

local Resources = {
    grass = {
        name = "Grass",
        sprites = { "assets/Grass.png", "assets/Grass_2.png" },
        pos = vec2(0, 0),
        size = vec2(8, 8),
    },
    rock = {
        name = "Rock",
        sprites = { "assets/Rock.png" },
        pos = vec2(0, 0),
        collider = { pos = vec2(0, 4), size = vec2(5, 3) },
        size = vec2(8, 8),
    },
    tree = {
        name = "Tree",
        sprites = { "assets/Tree.png", "assets/Tree_2.png" },
        collider = { pos = vec2(0, 0), size = vec2(6, 8) },
        speed = 1,
        pos = vec2(-3, -8),
        size = vec2(11, 17),
    },
    bush = {
        name = "bush",
        sprites = { "assets/Bush.png" },
    },
    sunflower = {
        name = "sunflower",
        sprites = { "assets/Sunflower.png" },
    },
    tulip = {
        name = "tulip",
        sprites = { "assets/Tulip.png" },
    },
    fern = {
        name = "fern",
        sprites = { "assets/Fern.png" },
    }
}


function NewResource(res, pos)
    pos = pos or vec2(0, 0)
    local tb = Resources[res]
    tb.speed = tb.speed and tb.speed + math.random(0.2, 0.4) or math.random(0.3, 0.6)
    return Resource(tb, pos)
end
