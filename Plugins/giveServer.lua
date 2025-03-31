return function(context, players, itemName)
	local executor = context.Executor
	if not executor then
		return "You must be a player to give an item."
	end

	if not players or not itemName then
		return "Please specify valid players and item name."
	end

	local toolFolder = game:GetService("Lighting"):FindFirstChild("Tools")
	if not toolFolder then
		warn("The 'Tools' folder does not exist in Lighting. Please make sure it's there.")
		return "The 'Tools' folder is missing in Lighting."
	end

	local item = toolFolder:FindFirstChild(itemName)

	if not item then
		warn("The item could not be found in Lighting.Tools. Please check the item name.")
		return "The item could not be found."
	end

	local itemClone = item:Clone()

	local successMessages = {}

	for _, player in ipairs(players) do
		local playerCharacter = player.Character
		if playerCharacter then
			itemClone.Parent = playerCharacter
			table.insert(successMessages, player.Name .. " has been given the item: " .. itemName)
		else
			table.insert(successMessages, player.Name .. " does not have a character. Item not given.")
		end
	end

	return table.concat(successMessages, "\n")
end
