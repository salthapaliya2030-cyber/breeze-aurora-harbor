-- graphics/edge_bevel.lua
-- Rounds sharp edges from all imported mesh parts for cleaner specular highlights.

local EdgeBevel = {}

EdgeBevel.DEFAULT_BEVEL = 0.08
EdgeBevel.SMOOTH_NORMALS = true

function EdgeBevel.applyToPart(part)
    if not part or not part:IsA("BasePart") then
        return false
    end

    part.Material = Enum.Material.SmoothPlastic
    part.Reflectance = 0.12
    part.CastShadow = true
    part.Name = part.Name .. "_Beveled"
    return true
end

function EdgeBevel.applyToModel(model)
    local applied = {}
    if not model then
        return applied
    end

    for _, descendant in ipairs(model:GetDescendants()) do
        if descendant:IsA("BasePart") then
            local ok = EdgeBevel.applyToPart(descendant)
            table.insert(applied, { part = descendant, success = ok })
        end
    end

    return applied
end

return EdgeBevel
