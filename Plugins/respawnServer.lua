return function(context, players)
	if #players == 0 then
		table.insert(players, context.Executor)
	end

	local count = 0

	for _, player in pairs(players) do
		if player.Character then
			player:LoadCharacter()
			count = count + 1
		end
	end

	return ("Respawned %d players."):format(count)
end
