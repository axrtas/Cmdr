local InsertService = game:GetService("InsertService")

return function(context, players, gearID)
	local executor = context.Executor

	if not tonumber(gearID) then
		return "Invalid gear ID. Please enter a valid number."
	end

	local gearModel
	local success, err = pcall(function()
		gearModel = InsertService:LoadAsset(tonumber(gearID))
	end)

	if not success or not gearModel then
		return "Failed to load the gear. Error: " .. (err or "Unknown error")
	end

	local tool = gearModel:FindFirstChildOfClass("Tool")
	if not tool then
		return "The asset does not contain a valid Tool."
	end

	local successMessages = {}
	for _, player in ipairs(players) do
		if player and player.Character then
			local clonedTool = tool:Clone()
			clonedTool.Parent = player.Backpack
			table.insert(successMessages, player.Name .. " has received the gear: " .. tool.Name)
		else
			table.insert(successMessages, player.Name .. " is not in the game or has no character.")
		end
	end

	gearModel:Destroy()

	return table.concat(successMessages, "\n")
end
