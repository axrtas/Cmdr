return function(context, players)
	local healer = context.Executor
	local healerName = healer and healer.Name or "Unknown"
	local healMessage = ""

	for _, player in pairs(players) do
		if player and player.Character then
			local humanoid = player.Character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				if humanoid.Health == humanoid.MaxHealth then
					healMessage = healMessage .. player.Name .. " is already at full health.\n"
				else
					humanoid.Health = humanoid.MaxHealth
					healMessage = healMessage .. player.Name .. " has been healed by " .. healerName .. ".\n"
				end
			else
				healMessage = healMessage .. player.Name .. " does not have a humanoid to heal.\n"
			end
		else
			healMessage = healMessage .. player.Name .. " is not a valid player or character.\n"
		end
	end

	return healMessage
end
