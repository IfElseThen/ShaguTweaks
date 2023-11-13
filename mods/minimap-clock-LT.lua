local _G = ShaguTweaks.GetGlobalEnv()

local module = ShaguTweaks:register({
  title = "MiniMap Clock - 24h Local Time",
  description = "Adds a small 24h clock to the MiniMap showing Local Time.",
  expansions = { ["vanilla"] = true, ["tbc"] = nil },
  category = "World & MiniMap",
  enabled = nil,
})

MinimapClock = CreateFrame("Frame", "Clock", Minimap)
MinimapClock:Hide()
MinimapClock:SetFrameLevel(64)
MinimapClock:SetPoint("BOTTOM", MinimapCluster, "BOTTOM", 8, 18)
MinimapClock:SetWidth(50)
MinimapClock:SetHeight(23)
MinimapClock:SetBackdrop({
  bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
  tile = true, tileSize = 8, edgeSize = 16,
  insets = { left = 3, right = 3, top = 3, bottom = 3 }
})
MinimapClock:SetBackdropBorderColor(.9,.8,.5,1)
MinimapClock:SetBackdropColor(.4,.4,.4,1)

module.enable = function(self)
  MinimapClock:Show()
  MinimapClock:EnableMouse(true)

  MinimapClock.text = MinimapClock:CreateFontString("Status", "LOW", "GameFontNormal")
  MinimapClock.text:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
  MinimapClock.text:SetAllPoints(MinimapClock)
  MinimapClock.text:SetFontObject(GameFontWhite)
  MinimapClock:SetScript("OnUpdate", function()
    -- Show Local Time in Clock Display
    this.text:SetText(date("%H:%M"))
  end)

  MinimapClock:SetScript("OnEnter", function()
    local h, m = GetGameTime()
    local servertime = string.format("%.2d:%.2d", h, m)
    local time = date("%H:%M")

    GameTooltip:ClearLines()
    GameTooltip:SetOwner(this, ANCHOR_BOTTOMLEFT)

    GameTooltip:AddLine("Clock")
    GameTooltip:AddDoubleLine("Localtime", time, 1,1,1,1,1,1)
    GameTooltip:AddDoubleLine("Servertime", servertime, 1,1,1,1,1,1)
    GameTooltip:Show()
  end)

  MinimapClock:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
end