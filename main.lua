_G.love = require("love")
require("utlis")
require "Player"
require "Cell"
require "Inventory"
require("CollisionManager")
require("Resources")
local PM = require "ParticleManager"

local player
local cells = {}
local inventory = Inventory()
local cursor
local font
local particle

local outer_table = {
    "                                           ",
    "  R                                        ",
    "T   T         R                            ",
    "T TR T              G                      ",
    "T T T     G          R                     ",
    " T T  G       G                            ",
    " T T  G  R             G      G            ",
    "T T G R            G       G               ",
    " T         G          G      T             ",
    "TG T T       B          T  T   G           ",
    "G T T    B B             T  T        G     ",
    "T  G SS  B                                 ",
    "   SSGSSt                                  ",
    "  G SStt              G                    ",
    "  tt  t             G                      ",
    "    tt F             G                     ",
    "    F F           G                        ",
    "       F                                   ",
    "                                           ",
    "                                           ",
    "                                           ",
    "                   G                       ",
    "            G      G                       "
}


function love.load()
    love.graphics.setDefaultFilter("nearest")
    font = love.graphics.newImageFont("assets/Fonts/font.png",
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 !", 1)
    cursor = love.mouse.newCursor("assets/Cursor.png")
    player = Player({ pos = vec2(120, 100), speed = 80 })
    for j = 0, 22 do
        local row = outer_table[j + 1]

        for i = 0, #row do
            local cell = Cell({ pos = vec2(i * 8, j * 8), size = vec2(8, 8), PM = PM })
            local res = nil
            local currTile = row:sub(i, i)
            if currTile == "T" then
                res = "tree"
            elseif currTile == "R" then
                res = "rock"
            elseif currTile == "B" then
                res = "bush"
            elseif currTile == "G" then
                res = "grass"
            elseif currTile == "S" then
                res = "sunflower"
            elseif currTile == "F" then
                res = "fern"
            elseif currTile == "t" then
                res = "tulip"
            end
            if res then
                cell.resource = NewResource(res, cell.pos)
            end
            table.insert(cells, cell)
        end

        -- NewParticle({ pos = vec2(100, 100) })
        -- PM = ParticleManager()
    end


    inventory:addItem("hoe")
    inventory:addItem("water_can")
    inventory:addItem("wheat_seed")
    inventory:addItem("carrot_seed")
    inventory:addItem("cabbage_seed")
    inventory:addItem("potato_seed")
    inventory:addItem("cauliflower_seed")

    -- PM.newParticle({ pos = vec2(100, 100) })

    -- particle = Particles()
end

function love.update(dt)
    player:update(dt, {
        holdingItem = inventory.selectedItem
    })
    for i, cell in pairs(cells) do
        cell:update(dt, {
            playerPos = player.pos,
            runningTime = love.timer.getTime()
        })
    end
    inventory:update()
    love.mouse.setCursor(cursor)
    PM:update(dt)
end

function love.mousepressed()
    inventory:selectItem()
    for i, cell in pairs(cells) do
        cell:interact(player.toolInUse)
    end
end

function love.draw()
    love.graphics.setFont(font)
    love.graphics.scale(GRAPHICS_SCALE)

    for i, cell in pairs(cells) do
        cell:draw()
    end

    local tb = { player }

    for i, cell in pairs(cells) do
        if cell.resource then
            table.insert(tb, cell.resource)
        end
        if cell.inReach and cell.interactable then
            love.graphics.setLineWidth = 1
            love.graphics.rectangle("line", cell.pos.x + 1, cell.pos.y + 1, cell.size.x - 2, cell.size.y - 2)
            love.graphics.setLineWidth = 1
        end
    end
    table.sort(tb, function(a, b)
        return a.pos.y + a.size.y / 2 < b.pos.y + b.size.y / 2
    end)
    for i, resource in pairs(tb) do
        resource:draw()
    end

    PM:draw()

    -- particle:draw()
    inventory:draw()

    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 170)
end
