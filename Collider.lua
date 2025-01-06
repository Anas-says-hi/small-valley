local colliders = {}
function Collider(pos, size, type)
    local col = {
        pos = pos,
        size = size,
        type = type or "static"
    }

    table.insert(colliders, col)

    return col
end

function getColliders()
    return colliders
end
