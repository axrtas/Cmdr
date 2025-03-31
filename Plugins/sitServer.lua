return function(context, targetPlayer)
	if not targetPlayer then
		targetPlayer = context.Executor
	end

	if not targetPlayer then
		return "Player not found."
	end

	local character = targetPlayer.Character
	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if humanoid.Sit then
				return targetPlayer.Name .. " is already sitting."
			end
			humanoid.Sit = true
			return targetPlayer.Name .. " is now sitting."
		else
			return "No Humanoid found in " .. targetPlayer.Name .. "'s character."
		end
	end

	return "Player has no character."
end
