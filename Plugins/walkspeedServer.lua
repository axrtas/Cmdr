return function(context, speed, targetPlayers)
	if not tonumber(speed) then
		return "Invalid speed value. Please provide a valid number."
	end

	speed = tonumber(speed)

	if speed < 0 or speed > 500 then
		return "Invalid speed. Please enter a speed between 0 and 500."
	end

	if not targetPlayers or #targetPlayers == 0 then
		targetPlayers = {context.Executor}
	end

	for _, player in ipairs(targetPlayers) do
		local character = player.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.WalkSpeed = speed
			else
				return player.Name .. " does not have a humanoid."
			end
		else
			return player.Name .. " does not have a character."
		end
	end

	if #targetPlayers == 1 then
		return ("Set walk speed of %s to %d."):format(targetPlayers[1].Name, speed)
	else
		return ("Set walk speed of %d players to %d."):format(#targetPlayers, speed)
	end
end
