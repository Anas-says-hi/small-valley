_G.love = require("love")
require("utils")
require "Player"
require "Cell"
local inventory = require "Inventory"
require("Resources")
require "Camera"
local EntityManager = require "Entity"
local PM = require "ParticleManager"
local Shop = require "Shop"
local player
local cells = {}
local default
local font
local camera
local allResorces = {}
local moneySprite = nil
local pointer = nil
local cursor

function setCursor(c)
    if c == "default" then
        cursor = default
    elseif c == "pointer" then
        cursor = pointer
    end
end

local map = {
    "                                              ",
    "  R                                           ",
    "T   T         R                               ",
    "T TR T              G                         ",
    "T T T     G          R                        ",
    " T T  G       G                               ",
    " T T  G  R             G      G               ",
    "T T G R            G       G                  ",
    " T         G          G      T                ",
    "TG T T       B          T  T   G              ",
    "G T T    B B             T  T        G        ",
    "T  G SS  B                                    ",
    "   SSGSSt                                     ",
    "  G SStt              G                       ",
    "  tt  t             G                         ",
    "    tt F             G                        ",
    "    F F           G                           ",
    "       F                                      ",
    "                                              ",
    "                                              ",
    "                                              ",
    "                   G                          ",
    "                                              ",
    "                                              ",
    "                         XXX                  ",
    "                         XXX                  ",
    "                         XYX                  ",
    "                         XXX                  ",
    "                                              ",
    "                                              ",

}


function love.load()
    love.graphics.setDefaultFilter("nearest")
    font = love.graphics.newImageFont("assets/Fonts/font.png",
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 !+-.$", 1)
    moneySprite = love.graphics.newImage("assets/Buck.png")
    default = love.mouse.newCursor("assets/Cursor.png")
    pointer = love.mouse.newCursor("assets/Pointer.png")
    cursor = default
    setCursor(cursor)
    player = Player({ pos = vec2(180, 90), speed = 80 })
    for j = 0, #map - 1 do
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
            elseif currTile == "X" then
                cell.farmable = false
            elseif currTile == "Y" then
                res = "shopkeeper"
                cell.farmable = false
            elseif currTile == "t" then
                res = "tulip"
            end
            if res then
                cell.resource = NewResource(res, cell.pos)
            end
            table.insert(cells, cell)
        end
    end

    inventory:addItem("hoe")
    inventory:addItem("axe")
    inventory:addItem("pickaxe")
    inventory:addItem("shovel")
    inventory:addItem("water_can")
    inventory:addItem("cabbage", 64)
    inventory:addItem("strawberry", 64)

    camera = Camera()
end

function love.update(dt)
    allResorces = { player }
    Shop.player = player
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
    Shop:update(dt)
    love.mouse.setCursor(cursor)
    PM:update(dt)
    camera:follow(player.pos, dt)
    EntityManager:update()
end

function love.mousepressed()
    inventory:selectItem()
    for i, cell in pairs(cells) do
        cell:interact(player.toolInUse and player.toolInUse.item and player.toolInUse.item or nil)
    end
    Shop:onClick()
end

function love.keypressed(key)
    if key == "1" then
        inventory:selectItemByIndex(1)
    elseif key == "2" then
        inventory:selectItemByIndex(2)
    elseif key == "3" then
        inventory:selectItemByIndex(3)
    elseif key == "4" then
        inventory:selectItemByIndex(4)
    elseif key == "5" then
        inventory:selectItemByIndex(5)
    elseif key == "6" then
        inventory:selectItemByIndex(6)
    elseif key == "7" then
        inventory:selectItemByIndex(7)
    elseif key == "8" then
        inventory:selectItemByIndex(8)
    elseif key == "9" then
        inventory:selectItemByIndex(9)
    end

    if key == "return" or key == "e" and player.canOpenShop then
        Shop.active = true
    end

    if key == "escape" and Shop.active then
        Shop.active = false
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
    EntityManager:draw()
    if selectBox.pos then
        love.graphics.setLineWidth = 1
        love.graphics.rectangle("line", selectBox.pos.x + 1, selectBox.pos.y + 1, selectBox.size.x - 2,
            selectBox.size.y - 2)
    end


    PM:draw()
    local text = love.graphics.newText(love.graphics.getFont(), string.upper(player.money))
    if player.canOpenShop then
        drawLabel("Press E", player.pos)
    end
    camera:stop()

    drawLabel(tostring(player.money), vec2(320 - text:getWidth(), 3), 2, 1)
    love.graphics.draw(moneySprite, 320 - text:getWidth() - 17, 1)

    inventory:draw()
    if Shop.active then
        Shop:draw()
    end

    drawLabel("FPS: " .. love.timer.getFPS(), vec2(6, 172))
end
