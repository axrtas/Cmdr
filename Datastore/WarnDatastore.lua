game.Players.PlayerAdded:Connect(function(plr)
local DataStoreService = game:GetService("DataStoreService")
local warnDataStore = DataStoreService:GetDataStore("PlayerWarnings")
local WarningFolder = Instance.new("Folder")
WarningFolder = Instance.new("Folder")
WarningFolder.Name = "WarningsFolder"
WarningFolder.Parent = plr
		
local function getWarnings(player)
	local playerId = player.UserId
	local success, storedData = pcall(function()
		return warnDataStore:GetAsync(tostring(playerId))
	end)

	if success and storedData then
		return storedData
	else
		return { count = 0, reasons = {} }
	end
end

local function setWarnings(player, warningData)
	local playerId = player.UserId
	local success, err = pcall(function()
		warnDataStore:SetAsync(tostring(playerId), warningData)
	end)

	if not success then
		warn("Failed to save warning data for " .. player.Name .. ": " .. err)
	end
end

return {
	getWarnings = getWarnings,
	setWarnings = setWarnings
}
end)
