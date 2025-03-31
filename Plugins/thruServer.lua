return function(context, distance)
	local player = context.Executor
	if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
		return "You must be a player with a character to use this command."
	end

	local rootPart = player.Character.HumanoidRootPart
	local lookVector = rootPart.CFrame.LookVector
	local newPosition = rootPart.Position + (lookVector * distance)

	local region = Region3.new(
		newPosition - Vector3.new(2, 2, 2),
		newPosition + Vector3.new(2, 2, 2)
	)
	local parts = workspace:FindPartsInRegion3(region, player.Character, math.huge)

	if #parts > 0 then
		return "Cannot teleport forward, obstruction detected!"
	end

	rootPart.CFrame = rootPart.CFrame + (lookVector * distance)
	return "Teleported forward " .. distance .. " studs."
end
