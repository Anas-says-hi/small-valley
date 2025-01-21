require("Crop")

love.graphics.setDefaultFilter("nearest")
local Crops = {
    wheat = {
        name = "wheat",
        speed = 2,
        stateSprites = {
            planted = sprite("assets/Planted_wheat.png"),
            growing = sprite("assets/Growing_wheat.png"),
            grown = sprite("assets/Grown_wheat.png")
        },
        drop = "wheat"
    },
    carrot = {
        name = "carrot",
        speed = 2,
        stateSprites = {
            planted = sprite("assets/Planted_carrot.png"),
            growing = sprite("assets/Growing_carrot.png"),
            grown = sprite("assets/Grown_carrot.png")
        },
        drop = "carrot"
    },
    cabbage = {
        name = "cabbage",
        speed = 2,
        stateSprites = {
            planted = sprite("assets/Planted_cabbage.png"),
            growing = sprite("assets/Growing_cabbage.png"),
            grown = sprite("assets/Grown_cabbage.png")
        },
        drop = "cabbage"

    },
    potato = {
        name = "potato",
        speed = 2,
        stateSprites = {
            planted = sprite("assets/Planted_potato.png"),
            growing = sprite("assets/Growing_potato.png"),
            grown = sprite("assets/Grown_potato.png")
        },
        drop = "potato"
    },
    cauliflower = {
        name = "cauliflower",
        speed = 2,
        stateSprites = {
            planted = sprite("assets/Planted_cauliflower.png"),
            growing = sprite("assets/Growing_cauliflower.png"),
            grown = sprite("assets/Grown_cauliflower.png")
        },
        drop = "cauliflower"

    },
}

function NewCrop(crop, soil)
    return Crop(Crops[crop], soil)
end
