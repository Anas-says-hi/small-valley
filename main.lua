_G.love = require("love")
require("utlis")
require "Player"
require "Cell"
require "Inventory"
require("CollisionManager")
require("Resources")
local player
local cells = {}
local inventory = Inventory()
local cursor
local font
function love.load()
    love.graphics.setDefaultFilter("nearest")
    font = love.graphics.newImageFont("assets/Fonts/font.png",
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 !", 1)
    cursor = love.mouse.newCursor("assets/Cursor.png")
    player = Player({ pos = vec2(120, 100), speed = 100 })
    for i = 0, 40, 1 do
        for j = 0, 22, 1 do
            local rand = math.random(1, 50)
            local rand2 = math.random(1, 80)
            local pos = vec2(i * 8, j * 8)
            table.insert(cells, Cell({
                pos = pos,
                resource = rand == 1 and NewResource("grass", pos) or
                    rand2 == 2 and NewResource("rock", pos) or
                    rand2 == 4 and NewResource("bush", pos) or
                    rand2 == 3 and NewResource("tree", pos) or
                    nil
            }))
        end
    end

    inventory:addItem("hoe")
    inventory:addItem("water_can")
    inventory:addItem("wheat_seed")
    inventory:addItem("carrot_seed")
    inventory:addItem("cabbage_seed")
    inventory:addItem("potato_seed")
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

    for i, cell in pairs(cells) do
        if cell.resource then
            cell.resource:draw()
        end
        if cell.inReach and cell.interactable then
            love.graphics.setLineWidth = 1
            love.graphics.rectangle("line", cell.pos.x + 1, cell.pos.y + 1, cell.size.x - 2, cell.size.y - 2)
            love.graphics.setLineWidth = 1
        end
    end

    player:draw()

    -- player:draw()
    inventory:draw()
end
