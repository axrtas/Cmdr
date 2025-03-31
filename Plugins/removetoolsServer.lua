return function(context, players)
	local executor = context.Executor
	local executorName = executor and executor.Name or "Unknown Executor"
	local removalMessage = ""

	-- Iterate over all players
	for _, player in pairs(players) do
		if player and player.Character then
			local character = player.Character
			local toolsRemoved = 0

			-- Iterate over the character's children to find and remove tools
			for _, item in pairs(character:GetChildren()) do
				if item:IsA("Tool") then
					item:Destroy()
					toolsRemoved = toolsRemoved + 1
				end
			end

			if toolsRemoved > 0 then
				removalMessage = removalMessage .. player.Name .. " had " .. toolsRemoved .. " tools removed.\n"
			else
				removalMessage = removalMessage .. player.Name .. " has no tools to remove.\n"
			end
		else
			removalMessage = removalMessage .. "Player " .. player.Name .. " is not in the game or has no character.\n"
		end
	end

	return removalMessage
end
