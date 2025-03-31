local DataStoreService = game:GetService("DataStoreService")
local banDataStore = DataStoreService:GetDataStore("TempBanDataStore")

game.Players.PlayerAdded:Connect(function(player)
	local userId = player.UserId

	local success, banData = pcall(function()
		return banDataStore:GetAsync(userId)
	end)

	if success and banData then
		local currentTime = os.time()

		if currentTime < banData.expiresAt then
			player:Kick("FSA Services | You have been temporarily banned  (" .. math.floor((banData.expiresAt - currentTime) / 60) .. ") by " .. banData.moderator .. " due to: " .. banData.reason)
		else
			local successRemove, errorMessage = pcall(function()
				banDataStore:RemoveAsync(userId)
			end)
			if not successRemove then
				warn("Error removing expired ban data for user " .. player.Name .. ": " .. errorMessage)
			end
		end
	end
end)
