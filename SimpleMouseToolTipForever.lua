local X_OFFSET, Y_OFFSET = 10, 10

hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
    tooltip:SetOwner(parent, "ANCHOR_CURSOR")
end)

GameTooltip:SetScript("OnUpdate", function(tooltip)
    if not tooltip:IsShown() then return end

    local x, y = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()

    tooltip:ClearAllPoints()
    tooltip:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT",
        x / scale + X_OFFSET,
        y / scale + Y_OFFSET)
end)
