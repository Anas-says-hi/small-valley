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
        }
    },
    carrot = {
        name = "carrot",
        speed = 2,
        stateSprites = {
            planted = sprite("assets/Planted_carrot.png"),
            growing = sprite("assets/Growing_carrot.png"),
            grown = sprite("assets/Grown_carrot.png")
        }
    },
    cabbage = {
        name = "cabbage",
        speed = 2,
        stateSprites = {
            planted = sprite("assets/Planted_cabbage.png"),
            growing = sprite("assets/Growing_cabbage.png"),
            grown = sprite("assets/Grown_cabbage.png")
        }
    },
    potato = {
        name = "potato",
        speed = 2,
        stateSprites = {
            planted = sprite("assets/Planted_potato.png"),
            growing = sprite("assets/Growing_potato.png"),
            grown = sprite("assets/Grown_potato.png")
        }
    },
}

function NewCrop(crop, soil)
    return Crop(Crops[crop], soil)
end
