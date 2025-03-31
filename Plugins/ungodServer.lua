return function(context, players)
	local executor = context.Executor
	if not executor then
		return "You must be a player to ungod someone."
	end

	local successMessages = {}

	for _, player in ipairs(players) do
		local playerCharacter = player.Character
		if playerCharacter then
			local humanoid = playerCharacter:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.MaxHealth = 100
				humanoid.Health = 100
				humanoid:SetAttribute("GodMode", false) 
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
				table.insert(successMessages, player.Name .. " is no longer in God mode.")
			else
				table.insert(successMessages, player.Name .. " does not have a humanoid.")
			end
		else
			table.insert(successMessages, player.Name .. " does not have a character.")
		end
	end

	return table.concat(successMessages, "\n")
end