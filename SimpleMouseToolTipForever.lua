-- SimpleMouseTooltip
-- Tooltip follows the mouse cursor with configurable X/Y offset.

local X_OFFSET = 10
local Y_OFFSET = 10

local tooltipFollowing = false


--------------------------------------------------
-- Set initial anchor
--------------------------------------------------

hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)

    tooltip:SetOwner(parent, "ANCHOR_CURSOR")

    tooltipFollowing = true

end)


--------------------------------------------------
-- Follow mouse cursor
--------------------------------------------------

GameTooltip:HookScript("OnShow", function(tooltip)

    tooltipFollowing = true

end)

GameTooltip:HookScript("OnHide", function(tooltip)

    tooltipFollowing = false

end)


GameTooltip:SetScript("OnUpdate", function(tooltip)

    if not tooltipFollowing then
        return
    end

    if not tooltip:IsShown() then
        return
    end

    local cursorX, cursorY = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()

    cursorX = cursorX / scale
    cursorY = cursorY / scale

    tooltip:ClearAllPoints()

    tooltip:SetPoint(
        "BOTTOMLEFT",
        UIParent,
        "BOTTOMLEFT",
        cursorX + X_OFFSET,
        cursorY + Y_OFFSET
    )

end)
