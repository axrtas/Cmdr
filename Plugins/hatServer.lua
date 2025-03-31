local InsertService = game:GetService("InsertService")

return function(context, players, hatID)
	local executor = context.Executor

	if not tonumber(hatID) then
		return "Invalid hat ID. Please enter a valid number."
	end

	local hatModel
	local success, err = pcall(function()
		hatModel = InsertService:LoadAsset(tonumber(hatID))
	end)

	if not success or not hatModel then
		return "Failed to load the hat. Error: " .. (err or "Unknown error")
	end

	local accessory = hatModel:FindFirstChildOfClass("Accessory")
	if not accessory then
		return "The asset does not contain a valid Accessory."
	end

	local successMessages = {}
	for _, player in ipairs(players) do
		if player and player.Character then
			local clonedAccessory = accessory:Clone()
			clonedAccessory.Parent = player.Character
			table.insert(successMessages, player.Name .. " has received the hat: " .. accessory.Name)
		else
			table.insert(successMessages, player.Name .. " is not in the game or has no character.")
		end
	end

	hatModel:Destroy()

	return table.concat(successMessages, "\n")
end
