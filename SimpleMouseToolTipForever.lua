-- SimpleMouseToolTipForever: makes the default tooltip follow the cursor.
local X_OFFSET, Y_OFFSET = 10, 10

local followCursor = false

hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
    -- Forbidden frames (e.g. enemy nameplates in instances) can't be touched
    -- by addon code, so leave those tooltips to Blizzard.
    followCursor = tooltip == GameTooltip and not parent:IsForbidden()
    if followCursor then
        tooltip:SetOwner(parent, "ANCHOR_NONE") -- positioned by OnUpdate below
    end
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
