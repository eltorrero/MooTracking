local MooTrackingFrame = CreateFrame("FRAME", "MooTrackingFrame", UIParent)
MooTrackingFrame:SetSize(400, 100) -- width, height
MooTrackingFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 250)
MooTrackingFrame:RegisterEvent("ADDON_LOADED")
MooTrackingFrame:RegisterEvent("PLAYER_ENTERING_WORLD")


MooTrackingFrame.txtNotification = MooTrackingFrame:CreateFontString(nil, "OVERLAY")
MooTrackingFrame.txtNotification:SetFontObject("GameFontNormalHuge")
MooTrackingFrame.txtNotification:SetPoint("CENTER", MooTrackingFrame, "CENTER", 0, 0)
MooTrackingFrame.txtNotification:Hide()

-- 136025 is Mining Texture ID
-- 2580 is Resource Tracking Spell ID for Mining
-- 133939 is Herbal Texture ID
-- 2383 is Resource Tracking Spell ID for Herbal
MooTrackingFrame.textureToCheck = 0

MooTrackingFrame:SetScript("OnEvent", function(self, event, name)
    if event=="ADDON_LOADED" and name=="MooTracking" then
        MooTrackingFrame:UnregisterEvent("ADDON_LOADED")
        self.timeSinceLastUpdate = 0
    end
	if event=="PLAYER_ENTERING_WORLD" then
		if IsPlayerSpell(2580) then
			self.textureToCheck=136025
			self.txtNotification:SetText("Mineraliensuche anschalten!")
		end
		if IsPlayerSpell(2383) then
			self.textureToCheck=133939
			self.txtNotification:SetText("Kräutersuche anschalten!")
		end
	end
end)


MooTrackingFrame:SetScript("OnUpdate", function(self, elapsedTime)
    self.timeSinceLastUpdate = self.timeSinceLastUpdate + elapsedTime
    -- use game tick to run code every x seconds
	if self.timeSinceLastUpdate > 2.0 then
		if MiniMapTrackingFrame:IsShown() and MiniMapTrackingIcon:GetTexture()==self.textureToCheck then
			if MooTrackingFrame.txtNotification:IsShown() then MooTrackingFrame.txtNotification:Hide() end
		else
			if not MooTrackingFrame.txtNotification:IsShown() then MooTrackingFrame.txtNotification:Show() end
		end
        self.timeSinceLastUpdate = 0
    end
end)
