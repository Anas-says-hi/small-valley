require("Hoe")
require("WaterCan")
require("Seed")
require("Axe")
require("Item")
require("Shovel")
require("Pickaxe")
love.graphics.setDefaultFilter("nearest")

local Items = {
    hoe = Hoe(),
    water_can = WaterCan(),
    axe = Axe(),
    shovel = Shovel(),
    pickaxe = Pickaxe(),
    wheat_seed = Seed({
        id = "wheat_seed",
        name = "Wheat Seeds",
        sprite = "assets/Wheat_seeds.png",
        buyable = true,
        price = 10,
        crop = "wheat"
    }),
    carrot_seed = Seed({
        id = "carrot_seed",
        name = "Carrot Seeds",
        sprite = "assets/Carrot_seeds.png",
        buyable = true,
        price = 10,
        crop = "carrot"
    }),
    cabbage_seed = Seed({
        id = "cabbage_seed",
        name = "Cabbage Seeds",
        sprite = "assets/Cabbage_seeds.png",
        buyable = true,
        price = 10,
        crop = "cabbage"
    }),
    potato_seed = Seed({
        id = "potato_seed",
        name = "Potato Seeds",
        sprite = "assets/Potato_seeds.png",
        buyable = true,
        price = 10,
        crop = "potato"
    }),
    cauliflower_seed = Seed({
        id = "cauliflower_seed",
        name = "Cauliflower Seeds",
        sprite = "assets/Cauliflower_seeds.png",
        buyable = true,
        price = 10,
        crop = "cauliflower"
    }),
    broccoli_seed = Seed({
        id = "broccoli_seed",
        name = "Broccoli Seeds",
        sprite = "assets/Broccoli_seeds.png",
        buyable = true,
        price = 100,
        crop = "broccoli"
    }),
    strawberry_seed = Seed({
        id = "strawberry_seed",
        name = "Strawberry Seeds",
        sprite = "assets/Strawberry_seeds.png",
        buyable = true,
        price = 10,
        crop = "strawberry"
    }),
    carrot = Item({
        id = "carrot",
        name = "Carrot",
        sellable = true,
        price = 20,
        sprite = "assets/Carrot.png"
    }),
    potato = Item({
        id = "potato",
        name = "Potato",
        sellable = true,
        price = 20,
        sprite = "assets/Potato.png"
    }),
    cauliflower = Item({
        id = "cauliflower",
        name = "Cauliflower",
        sellable = true,
        price = 20,
        sprite = "assets/Cauliflower.png"
    }),
    cabbage = Item({
        id = "cabbage",
        name = "Cabbage",
        sellable = true,
        price = 20,
        sprite = "assets/Cabbage.png"
    }),
    wheat = Item({
        id = "wheat",
        name = "Wheat",
        sellable = true,
        price = 20,
        sprite = "assets/Wheat.png"
    }),
    broccoli = Item({
        id = "broccoli",
        name = "Broccoli",
        sellable = true,
        price = 20,
        sprite = "assets/Broccoli.png"
    }),
    strawberry = Item({
        id = "strawberry",
        name = "Strawberry",
        sellable = true,
        price = 20,
        sprite = "assets/Strawberry.png"
    }),
    wood = Item({
        id = "wood",
        name = "Wood",
        sellable = true,
        price = 10,
        sprite = "assets/Wood.png"
    }),
    fishing_rod = Item({
        id = "fishing_rod",
        name = "fishing rod",
        sellable = false,
        sprite = "assets/Fishing_rod.png"
    })
}

return Items
