return function(context, players)
	local executor = context.Executor
	local successMessages = {}

	if not players or #players == 0 then
		players = {executor}
	end

	for _, player in ipairs(players) do
		local char = workspace:FindFirstChild(player.Name)
		if char then
			local rankTag = char:FindFirstChild("Rank")
			if rankTag and rankTag:IsA("BillboardGui") then
				if rankTag.Enabled then
					rankTag.Enabled = false
					table.insert(successMessages, player.Name .. "'s nametag is now hidden.")
				else
					table.insert(successMessages, player.Name .. "'s nametag is already hidden.")
				end
			else
				table.insert(successMessages, "No nametag found for " .. player.Name)
			end
		else
			table.insert(successMessages, player.Name .. " is not in the workspace.")
		end
	end

	return table.concat(successMessages, "\n")
end
