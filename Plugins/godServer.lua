return function(context, players)
	local executor = context.Executor
	if not executor then
		return "You must be a player to activate god mode."
	end

	local successMessages = {}

	for _, player in ipairs(players) do
		local playerCharacter = player.Character
		if playerCharacter then
			local humanoid = playerCharacter:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.MaxHealth = math.huge
				humanoid.Health = math.huge
				humanoid:SetAttribute("GodMode", true)
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
				table.insert(successMessages, player.Name .. " is now in God mode!")
			else
				table.insert(successMessages, player.Name .. " does not have a humanoid.")
			end
		else
			table.insert(successMessages, player.Name .. " does not have a character.")
		end
	end

	return table.concat(successMessages, "\n")
end