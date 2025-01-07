local colliders = {}
function Collider(pos, size, type)
    local col = {
        pos = pos,
        size = size,
        type = type or "static",
        remove = function(self)
            for i, collider in ipairs(colliders) do
                if collider == self then
                    table.remove(colliders, i)
                    break
                end
            end
        end
    }
    table.insert(colliders, col)

    return col
end

function getColliders()
    return colliders
end
