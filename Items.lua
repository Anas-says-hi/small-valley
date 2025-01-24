require("Hoe")
require("WaterCan")
require("Seed")
require("Axe")
require("Item")
require("Shovel")
love.graphics.setDefaultFilter("nearest")

local Items = {
    hoe = Hoe(),
    water_can = WaterCan(),
    axe = Axe(),
    shovel = Shovel(),
    wheat_seed = Seed({
        id = "wheat_seed",
        name = "Wheat Seeds",
        sprite = "assets/Wheat_seeds.png",
        crop = "wheat"
    }),
    carrot_seed = Seed({
        id = "carrot_seed",
        name = "Carrot Seeds",
        sprite = "assets/Carrot_seeds.png",
        crop = "carrot"
    }),
    cabbage_seed = Seed({
        id = "cabbage_seed",
        name = "Cabbage Seeds",
        sprite = "assets/Cabbage_seeds.png",
        crop = "cabbage"
    }),
    potato_seed = Seed({
        id = "potato_seed",
        name = "Potato Seeds",
        sprite = "assets/Potato_seeds.png",
        crop = "potato"
    }),
    cauliflower_seed = Seed({
        id = "cauliflower_seed",
        name = "Cauliflower Seeds",
        sprite = "assets/Cauliflower_seeds.png",
        crop = "cauliflower"
    }),
    broccoli_seed = Seed({
        id = "broccoli_seed",
        name = "Broccoli Seeds",
        sprite = "assets/Broccoli_seeds.png",
        crop = "broccoli"
    }),
    strawberry_seed = Seed({
        id = "strawberry_seed",
        name = "Strawberry Seeds",
        sprite = "assets/Strawberry_seeds.png",
        crop = "strawberry"
    }),
    carrot = Item({
        name = "Carrot",
        sprite = "assets/Carrot.png"
    }),
    potato = Item({
        name = "Potato",
        sprite = "assets/Potato.png"
    }),
    cauliflower = Item({
        name = "Cauliflower",
        sprite = "assets/Cauliflower.png"
    }),
    cabbage = Item({
        name = "Cabbage",
        sprite = "assets/Cabbage.png"
    }),
    wheat = Item({
        name = "Wheat",
        sprite = "assets/Wheat.png"
    }),
    broccoli = Item({
        name = "Broccoli",
        sprite = "assets/Broccoli.png"
    }),
    strawberry = Item({
        name = "Strawberry",
        sprite = "assets/Strawberry.png"
    }),
    wood = Item({
        name = "Wood",
        sprite = "assets/Wood.png"
    }),
}

return Items
