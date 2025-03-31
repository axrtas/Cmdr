return function (context, players, reason)
	reason = reason or "No reason provided"

	local moderator = context.Executor
	local moderatorName = moderator and moderator.Name or "Unknown Moderator"

	for _, player in pairs(players) do
		player:Kick("You've been kicked by moderator " .. moderatorName .. " due to: " .. tostring(reason))
	end

	return ("Kicked %d players by %s."):format(#players, moderatorName)
end
