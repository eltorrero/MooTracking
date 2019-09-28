local MooTrackingFrame = CreateFrame("FRAME", "MooTrackingFrame", UIParent)
MooTrackingFrame:SetSize(400, 100) -- width, height
MooTrackingFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 250)
MooTrackingFrame:RegisterEvent("ADDON_LOADED")


MooTrackingFrame.txtNotification = MooTrackingFrame:CreateFontString(nil, "OVERLAY")
MooTrackingFrame.txtNotification:SetFontObject("GameFontNormalHuge")
MooTrackingFrame.txtNotification:SetPoint("CENTER", MooTrackingFrame, "CENTER", 0, 0)
MooTrackingFrame.txtNotification:SetText("Mineraliensuche anschalten!")
MooTrackingFrame.txtNotification:Hide()


MooTrackingFrame:SetScript("OnEvent", function(self, event, name)
    if event=="ADDON_LOADED" and name=="MooTracking" then
        MooTrackingFrame:UnregisterEvent("ADDON_LOADED")
        self.timeSinceLastUpdate = 0
    end
end)


MooTrackingFrame:SetScript("OnUpdate", function(self, elapsedTime)
    self.timeSinceLastUpdate = self.timeSinceLastUpdate + elapsedTime
    -- use game tick to run code every x seconds
	if self.timeSinceLastUpdate > 10.0 then
		if MiniMapTrackingFrame:IsShown() and MiniMapTrackingIcon:GetTexture()==136025 then
			if MooTrackingFrame.txtNotification:IsShown() then MooTrackingFrame.txtNotification:Hide() end
		else
			if not MooTrackingFrame.txtNotification:IsShown() then MooTrackingFrame.txtNotification:Show() end
		end
        self.timeSinceLastUpdate = 0
    end
end)
