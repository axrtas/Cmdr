return function(context, targetPlayers)
	if #targetPlayers == 0 then
		table.insert(targetPlayers, context.Executor)
	end

	local refreshedCount = 0

	for _, targetPlayer in ipairs(targetPlayers) do
		if targetPlayer and targetPlayer.Character then
			local character = targetPlayer.Character
			local rootPart = character:FindFirstChild("HumanoidRootPart")

			local originalPosition = rootPart and rootPart.Position

			targetPlayer:LoadCharacter()

			if originalPosition then
				local newCharacter = targetPlayer.Character
				if newCharacter then
					local newRootPart = newCharacter:WaitForChild("HumanoidRootPart", 5)
					if newRootPart then
						newRootPart.CFrame = CFrame.new(originalPosition)
					end
				end
			end

			refreshedCount = refreshedCount + 1
		end
	end

	return ("Refreshed %d players and kept their positions."):format(refreshedCount)
end
