return function(context, players, team)
	if not team or not team.Name then
		return "Please provide a valid team name."
	end

	local executor = context.Executor
	local executorName = executor and executor.Name or "Unknown Executor"
	local changeMessage = ""

	for _, player in pairs(players) do
		if player and player.Character then
			local character = player.Character
			local currentTeam = player.Team

			if currentTeam ~= team then
				player.Team = team
				changeMessage = changeMessage .. player.Name .. " has been moved to team " .. team.Name .. ".\n"
			else
				changeMessage = changeMessage .. player.Name .. " is already on team " .. team.Name .. ".\n"
			end
		else
			changeMessage = changeMessage .. player.Name .. " does not have a character.\n"
		end
	end

	return changeMessage
end
