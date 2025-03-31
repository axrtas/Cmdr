return function(context, players)
	local successMessages = {}

	for _, player in ipairs(players) do
		local backpack = player:FindFirstChild("Backpack")
		if backpack then
			local existingTools = backpack:FindFirstChild("btools")
			if not existingTools then
				local btools = game:GetService("Lighting"):FindFirstChild("Tools")["Building Tools"]
				if btools then
					btools:Clone().Parent = backpack
					table.insert(successMessages, player.Name .. " has been given the btools.")
				else
					table.insert(successMessages, "F3X tools not found in ServerStorage.")
				end
			else
				table.insert(successMessages, player.Name .. " already has btools.")
			end
		else
			table.insert(successMessages, "Could not find backpack for " .. player.Name)
		end
	end

	return table.concat(successMessages, "\n")
end
