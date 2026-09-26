-- SimpleMouseToolTipForever: makes the default tooltip follow the cursor.
local X_OFFSET, Y_OFFSET = 10, 10

local followCursor = false

local function Follow(tooltip)
    if not followCursor then return end
    local x, y = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()
    tooltip:ClearAllPoints()
    tooltip:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x / scale + X_OFFSET, y / scale + Y_OFFSET)
end

hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
    -- Forbidden frames (e.g. enemy nameplates in instances) can't be touched by addon code.
    followCursor = tooltip == GameTooltip and not parent:IsForbidden()
    Follow(tooltip) -- right away, so the tooltip is never shown unanchored
end)

GameTooltip:HookScript("OnUpdate", Follow)
GameTooltip:HookScript("OnHide", function() followCursor = false end)
