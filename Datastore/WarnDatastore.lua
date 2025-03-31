game.Players.PlayerAdded:Connect(function(plr)
local DataStoreService = game:GetService("DataStoreService")
local warnDataStore = DataStoreService:GetDataStore("PlayerWarnings") -- DataStore for storing warnings
local WarningFolder = Instance.new("Folder")
WarningFolder = Instance.new("Folder")
WarningFolder.Name = "WarningsFolder"
WarningFolder.Parent = plr
-- Function to get or set warning counts and reasons for a player
local function getWarnings(player)
	local playerId = player.UserId
	local success, storedData = pcall(function()
		return warnDataStore:GetAsync(tostring(playerId))
	end)

	if success and storedData then
		return storedData -- Return stored data which contains both count and reasons
	else
		return { count = 0, reasons = {} }  -- Return a table with default values if not found
	end
end

local function setWarnings(player, warningData)
	local playerId = player.UserId
	local success, err = pcall(function()
		warnDataStore:SetAsync(tostring(playerId), warningData)  -- Store both count and reasons
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
