local colliders = {}
function Collider(pos, size, id)
    local col = {
        pos = pos,
        size = size,
        id = id,
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
