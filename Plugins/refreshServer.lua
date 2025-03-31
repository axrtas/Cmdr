return function(context, targetPlayers)
	-- If no player is provided, default to the executor
	if #targetPlayers == 0 then
		table.insert(targetPlayers, context.Executor)
	end

	local refreshedCount = 0

	for _, targetPlayer in ipairs(targetPlayers) do
		if targetPlayer and targetPlayer.Character then
			local character = targetPlayer.Character
			local rootPart = character:FindFirstChild("HumanoidRootPart")

			-- Save original position before respawning
			local originalPosition = rootPart and rootPart.Position

			-- Respawn the character
			targetPlayer:LoadCharacter()

			-- Restore the position after respawn
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
