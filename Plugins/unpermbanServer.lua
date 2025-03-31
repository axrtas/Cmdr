local DataStoreService = game:GetService("DataStoreService")
local bannedPlayersStore = DataStoreService:GetDataStore("BannedPlayers")

return function (context, players)
	local moderator = context.Executor
	local moderatorName = moderator and moderator.Name or "Unknown Moderator"
	local unbanMessage = ""

	for _, player in pairs(players) do
		local userId = player.UserId

		local success, data = pcall(function()
			return bannedPlayersStore:GetAsync(userId)
		end)

		if success and data then
			local removeSuccess, removeError = pcall(function()
				bannedPlayersStore:RemoveAsync(userId)
			end)

			if removeSuccess then
				unbanMessage = unbanMessage .. player.Name .. " has been unbanned by " .. moderatorName .. ".\n"
			else
				unbanMessage = unbanMessage .. "Failed to unban " .. player.Name .. ": " .. removeError .. "\n"
			end
		else
			unbanMessage = unbanMessage .. player.Name .. " was not currently banned.\n"
		end
	end

	return unbanMessage
end
