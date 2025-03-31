local BannedPlayersModule = require(game:GetService("ServerScriptService"):FindFirstChild("Cmdr").Tables.Ban)

return function (context, players)
	local moderator = context.Executor
	local moderatorName = moderator and moderator.Name or "Unknown Moderator"
	local unbanMessage = ""

	for _, player in pairs(players) do
		local userId = player.UserId

		if BannedPlayersModule.bannedPlayers[userId] then
			BannedPlayersModule.bannedPlayers[userId] = nil

			if player and player:IsDescendantOf(game) then
				player:SendNotification({
					Title = "Unbanned",
					Text = "You have been unbanned by " .. moderatorName .. "."
				})
			end

			unbanMessage = unbanMessage .. player.Name .. " has been unbanned by " .. moderatorName .. ".\n"
		else
			unbanMessage = unbanMessage .. player.Name .. " is not banned.\n"
		end
	end

	return unbanMessage
end