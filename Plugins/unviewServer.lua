return function(context)
	local executor = context.Executor
	if not executor then
		return "You need to be a player to stop viewing."
	end

	local character = executor.Character
	if not character then
		return "You do not have a character."
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return "Could not find humanoid for this character."
	end

	if humanoid.CameraSubject and humanoid.CameraSubject ~= humanoid then
		humanoid.CameraSubject = humanoid
		return "Camera reset to your original view."
	else
		return "You are not currently viewing anyone."
	end
end
