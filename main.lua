_G.love = require("love")
require("utils")
require "Player"
require "Cell"
require "Inventory"
require("Resources")
require "Camera"
local PM = require "ParticleManager"

local player
local cells = {}
local inventory = Inventory()
local cursor
local font
local camera
local allResorces = {}

local map = {
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
        local row = map[j + 1]

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
    end


    inventory:addItem("axe")
    inventory:addItem("hoe")
    inventory:addItem("water_can")
    inventory:addItem("wheat_seed")
    inventory:addItem("carrot_seed")
    inventory:addItem("cabbage_seed")
    inventory:addItem("potato_seed")
    inventory:addItem("cauliflower_seed")
    camera = Camera()
end

function love.update(dt)
    allResorces = { player }
    player:update(dt, {
        holdingItem = inventory.selectedItem
    })
    for i, cell in pairs(cells) do
        if cell.resource then
            table.insert(allResorces, cell.resource)
        end
        cell:update(dt, {
            playerPos = player.pos,
            runningTime = love.timer.getTime()
        })
    end
    inventory:update()
    love.mouse.setCursor(cursor)
    PM:update(dt)
    camera:follow(player.pos, dt)

    getWorldPos()
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

    camera:record()

    local selectBox = {}

    for i, cell in pairs(cells) do
        cell:draw()
        if cell.inReach and cell.interactable then
            selectBox = cell
        end
    end
    table.sort(allResorces, function(a, b)
        return a.pos.y + a.size.y / 2 < b.pos.y + b.size.y / 2
    end)
    for i, resource in pairs(allResorces) do
        resource:draw()
    end
    if selectBox.pos then
        love.graphics.setLineWidth = 1
        love.graphics.rectangle("line", selectBox.pos.x + 1, selectBox.pos.y + 1, selectBox.size.x - 2,
            selectBox.size.y - 2)
    end

    PM:draw()
    camera:stop()
    inventory:draw()
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 170)
end
