return function(context, players)
	if #players == 0 then
		players = {context.Executor}
	end

	for _, player in pairs(players) do
		local character = player.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				local humanoidState = humanoid:GetState()
				if humanoidState == Enum.HumanoidStateType.Jumping or humanoidState == Enum.HumanoidStateType.Freefall then
					return player.Name .. " is already in the air."
				end

				humanoid.Jump = true
				return "Hop!"
			else
				return "No humanoid found in " .. player.Name .. "'s character."
			end
		else
			return "Player " .. player.Name .. " has no character."
		end
	end
end
