require("Hoe")
require("WaterCan")
require("Seed")
require("Axe")
love.graphics.setDefaultFilter("nearest")

local Items = {
    hoe = Hoe(),
    water_can = WaterCan(),
    axe = Axe(),
    wheat_seed = Seed({
        name = "Wheat Seeds",
        sprite = "assets/Wheat_seeds.png",
        crop = "wheat"
    }),
    carrot_seed = Seed({
        name = "Carrot Seeds",
        sprite = "assets/Carrot_seeds.png",
        crop = "carrot"
    }),
    cabbage_seed = Seed({
        name = "Cabbage Seeds",
        sprite = "assets/Cabbage_seeds.png",
        crop = "cabbage"
    }),
    potato_seed = Seed({
        name = "Potato Seeds",
        sprite = "assets/Potato_seeds.png",
        crop = "potato"
    }),
    cauliflower_seed = Seed({
        name = "Cauliflower Seeds",
        sprite = "assets/Cauliflower_seeds.png",
        crop = "cauliflower"
    }),
}

return Items
