local X_OFFSET, Y_OFFSET = 10, 10

-- Forbidden frames (e.g. enemy nameplates in instances) can't be touched by
-- addon code, so leave those tooltips to Blizzard.
local function IsForbiddenFrame(frame)
    return frame ~= nil and frame:IsForbidden()
end

local followCursor = false

hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
    followCursor = false
    if tooltip ~= GameTooltip or IsForbiddenFrame(parent) then return end

    tooltip:SetOwner(parent, "ANCHOR_CURSOR")
    followCursor = true
end)

GameTooltip:HookScript("OnHide", function()
    followCursor = false
end)

GameTooltip:HookScript("OnUpdate", function(tooltip)
    if not followCursor then return end

    local x, y = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()

    tooltip:ClearAllPoints()
    tooltip:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT",
        x / scale + X_OFFSET,
        y / scale + Y_OFFSET)
end)
