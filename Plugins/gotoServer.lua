local goTosFolder = game:GetService("Lighting"):FindFirstChild("GoTos")

return function (context, locationName)
	if not locationName then
		return "No location specified."
	end

	local locationNames = {}
	for _, location in pairs(goTosFolder:GetChildren()) do
		if location:IsA("BasePart") then
			table.insert(locationNames, location.Name)
		end
	end

	local targetLocation = goTosFolder:FindFirstChild(locationName)

	if targetLocation then
		local player = context.Executor
		local character = player.Character
		if character and character:FindFirstChild("HumanoidRootPart") then
			character.HumanoidRootPart.CFrame = targetLocation.CFrame
			print(player.Name .. " was teleported to " .. locationName)
		else
			warn(player.Name .. " doesn't have a valid character or HumanoidRootPart!")
		end
		return "Teleported to location: " .. locationName
	else
		return "Location '" .. locationName .. "' not found in GoTos!"
	end
end
