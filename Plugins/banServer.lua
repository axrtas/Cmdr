local BannedPlayersModule = require(game:GetService("ServerScriptService"):FindFirstChild("Cmdr").Tables.Ban)

return function (context, players, reason)
	reason = reason or "No reason provided"

	local moderator = context.Executor
	local moderatorName = moderator and moderator.Name or "Unknown Moderator"
	local banMessage = ""

	for _, player in pairs(players) do
		local userId = player.UserId

		if not BannedPlayersModule.bannedPlayers[userId] then
			BannedPlayersModule.bannedPlayers[userId] = {
				reason = reason,
				moderator = moderatorName
			}

			if player and player:IsDescendantOf(game) then
				player:Kick("You have been server-banned by " .. moderatorName .. " due to: " .. tostring(reason))
			end

			banMessage = banMessage .. player.Name .. " has been banned by " .. moderatorName .. ".\n"
		else
			banMessage = banMessage .. player.Name .. " is already banned.\n"
		end
	end

	return banMessage
end
