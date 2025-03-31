return function(context, player)
	local executor = context.Executor
	if not executor then
		return "You need to be a player to view someone."
	end

	local executorCharacter = executor.Character
	if not executorCharacter then
		executorCharacter = executor.CharacterAdded:Wait()
	end

	local targetCharacter = player.Character
	if not targetCharacter then
		return "The specified player does not have a character."
	end

	local executorHumanoid = executorCharacter:FindFirstChildOfClass("Humanoid")
	if not executorHumanoid then
		return "Could not find a humanoid in your character."
	end

	local targetHumanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
	if not targetHumanoid then
		return "Could not find the target player's humanoid."
	end

	executorHumanoid.CameraSubject = targetHumanoid
	return "You are now viewing " .. player.Name
end
