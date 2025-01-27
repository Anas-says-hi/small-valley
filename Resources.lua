require("Resource")

local Resources = {
    grass = {
        name = "Grass",
        sprites = { "assets/Grass_1.png", "assets/Grass_2.png" },
        pos = vec2(0, 0),
        size = vec2(8, 8),
        destructable = true
    },
    rock = {
        name = "Rock",
        sprites = { "assets/Rock.png" },
        pos = vec2(0, 0),
        collider = { pos = vec2(0, 4), size = vec2(5, 3) },
        size = vec2(8, 8),
        destructable = true,
        type = "rock"
    },
    tree = {
        name = "Tree",
        sprites = { "assets/Tree.png", "assets/Tree_2.png" },
        collider = { pos = vec2(0, 0), size = vec2(6, 8) },
        speed = 1,
        pos = vec2(-1.5, -8),
        size = vec2(11, 17),
        destructable = true,
        drop = "wood"
    },
    bush = {
        name = "bush",
        sprites = { "assets/Bush.png" },
        destructable = true
    },
    sunflower = {
        name = "sunflower",
        sprites = { "assets/Sunflower.png" },
        destructable = true
    },
    tulip = {
        name = "tulip",
        sprites = { "assets/Tulip.png" },
        destructable = true
    },
    fern = {
        name = "fern",
        sprites = { "assets/Fern.png" },
        destructable = true
    },
    shopkeeper = {
        name = "shopkeeper",
        sprites = { "assets/Shopkeeper.png", "assets/Shopkeeper_frame_2.png" },
        collider = { pos = vec2(-21 / 4 + 1, 3), size = vec2(19, 9), id = "shop" },
        pos = vec2(-21 / 4, -25 / 2),
        speed = 1,
        size = vec2(21, 25),
        destructable = false
    }
}


function NewResource(res, pos)
    pos = pos or vec2(0, 0)
    local tb = Resources[res]
    tb.speed = tb.speed and tb.speed + math.random(0.2, 0.4) or math.random(0.3, 0.6)
    return Resource(tb, pos)
end
