local Shop = {}
Shop.items = {}
Shop.active = false
Shop.width = 100
Shop.height = 100

local w, h = love.window.getMode()

function Shop:update()

end

function Shop:draw()
    love.graphics.rectangle("fill", w / 8 - self.width / 2, h / 8 - self.height / 2, self.width, self.height)
end

return Shop
