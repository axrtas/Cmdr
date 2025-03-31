local DataStoreService = game:GetService("DataStoreService")
local bannedPlayersStore = DataStoreService:GetDataStore("BannedPlayers")

local function isPlayerBanned(player)
	local userId = player.UserId

	local success, bannedData = pcall(function()
		return bannedPlayersStore:GetAsync(userId)
	end)

	if success and bannedData then
		return true, bannedData.reason, bannedData.moderator
	else
		return false
	end
end

game.Players.PlayerAdded:Connect(function(player)
	local isBanned, reason, moderator = isPlayerBanned(player)

	if isBanned then
		player:Kick("You have been permanently banned by " .. moderator .. " due to: " .. reason)
	end
end)

return function (context, players, reason)
	reason = reason or "No reason provided"
	local moderator = context.Executor
	local moderatorName = moderator and moderator.Name or "Unknown Moderator"

	for _, player in pairs(players) do
		local userId = player.UserId

		local success, errorMessage = pcall(function()
			bannedPlayersStore:SetAsync(userId, {
				reason = reason,
				moderator = moderatorName
			})
		end)

		if success then
			player:Kick("You have been permanently banned by " .. moderatorName .. " due to: " .. tostring(reason))
		else
			warn("Failed to ban player " .. player.Name .. ": " .. errorMessage)
		end
	end

	return ("Banned %d players permanently by %s."):format(#players, moderatorName)
end
