return function(context)
	local playerCount = #game.Players:GetPlayers()

	return ("There are currently %d players in the game."):format(playerCount)
end
