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
local font
function love.load()
    love.graphics.setDefaultFilter("nearest")
    font = love.graphics.newImageFont("assets/Fonts/font.png",
        " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~", -1.5)
    player = Player({ pos = vec2(120, 100), speed = 100 })
    for i = 0, 25, 1 do
        for j = 0, 10, 1 do
            local rand = math.random(1, 20)
            local rand2 = math.random(1, 40)

            table.insert(cells, Cell({
                pos = vec2(50 + i * 8, 50 + j * 8),
                resource = rand == 1 and NewResource("grass", vec2(50 + i * 8, 50 + j * 8)) or
                    rand2 == 2 and NewResource("rock", vec2(50 + i * 8, 50 + j * 8)) or
                    rand2 == 3 and NewResource("tree", vec2(50 + i * 8, 50 + j * 8)) or
                    rand2 == 4 and NewResource("bush", vec2(50 + i * 8, 50 + j * 8)) or
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

    player:draw()
    inventory:draw()
end
