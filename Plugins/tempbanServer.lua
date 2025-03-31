local DataStoreService = game:GetService("DataStoreService")
local banDataStore = DataStoreService:GetDataStore("TempBanDataStore")

return function (context, players, reason, banDurationMinutes)
	reason = reason or "No reason provided"
	banDurationMinutes = banDurationMinutes or 5

	local moderator = context.Executor
	local moderatorName = moderator and moderator.Name or "Unknown Moderator"

	local currentTime = os.time() 
	local banDuration = banDurationMinutes * 60

	for _, player in pairs(players) do
		local userId = player.UserId
		local expirationTime = currentTime + banDuration

		local success, errorMessage = pcall(function()
			banDataStore:SetAsync(userId, {
				reason = reason,
				moderator = moderatorName,
				expiresAt = expirationTime
			})
		end)

		if not success then
			warn("Error saving ban data for user " .. player.Name .. ": " .. errorMessage)
		end

		if player.Parent then
			player:Kick("FSA Services | You have been temporarily banned for " .. banDurationMinutes .. " minutes by " .. moderatorName .. " due to: " .. tostring(reason))
		end
	end

	return ("Banned %d players temporarily by %s for %d minutes. (All-Server)"):format(#players, moderatorName, banDurationMinutes)
end
