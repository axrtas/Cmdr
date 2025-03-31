local DataStoreService = game:GetService("DataStoreService")
local bannedPlayersStore = DataStoreService:GetDataStore("BannedPlayers")

return function (context, players, reason)
	reason = reason or "No reason provided"
	local moderator = context.Executor
	local moderatorName = moderator and moderator.Name or "Unknown Moderator"
	local banMessage = ""

	for _, player in pairs(players) do
		local userId = player.UserId

		local success, errorMessage = pcall(function()
			bannedPlayersStore:SetAsync(userId, {
				reason = reason,
				moderator = moderatorName
			})
		end)

		if success then
			if player.Parent then
				player:Kick("You have been permanently banned by " .. moderatorName .. " due to: " .. tostring(reason))
			end

			banMessage = banMessage .. player.Name .. " has been banned by " .. moderatorName .. ".\n"
		else
			warn("Failed to ban player " .. player.Name .. ": " .. errorMessage)
		end
	end

	return banMessage
end
