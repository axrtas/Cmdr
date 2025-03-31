local Players = game:GetService("Players")

return function (registry)
	local playerType = {
		Transform = function (text)
			if text:lower() == "all" then
				return Players:GetPlayers()
			end

			local foundPlayers = {}
			for _, player in ipairs(Players:GetPlayers()) do
				if player.Name:lower():find(text:lower(), 1, true) then
					table.insert(foundPlayers, player)
				end
			end
			return foundPlayers
		end;

		Validate = function (players)
			if #players == 0 then
				return false, "No player with that name could be found."
			end
			return true
		end;

		Autocomplete = function (players)
			local names = {}
			for _, player in ipairs(players) do
				table.insert(names, player.Name)
			end
			return names
		end;

		Parse = function (players)
			if #players == 1 and players[1] == "all" then
				return Players:GetPlayers()
			end
			return players[1]
		end;

		Default = function(player)
			if type(player) == "table" then
				local playerNames = {}
				for _, p in ipairs(player) do
					table.insert(playerNames, p.Name)
				end
				return table.concat(playerNames, ", ")
			end
			return player.Name
		end;
	}

	registry:RegisterType("playerall", playerType)
	registry:RegisterType("playersall", {
		Transform = function (text)
			if text:lower() == "all" then
				return Players:GetPlayers()
			end

			local foundPlayers = {}
			for _, player in ipairs(Players:GetPlayers()) do
				if player.Name:lower():find(text:lower(), 1, true) then
					table.insert(foundPlayers, player)
				end
			end
			return foundPlayers
		end;

		Validate = function (players)
			if #players == 0 then
				return false, "No player with that name could be found."
			end
			return true
		end;

		Autocomplete = function (players)
			local names = {}
			for _, player in ipairs(players) do
				table.insert(names, player.Name)
			end
			return names
		end;

		Parse = function (players)
			if #players == 1 and players[1] == "all" then
				return Players:GetPlayers()
			end
			return players[1]
		end;

		Default = function(player)
			if type(player) == "table" then
				local playerNames = {}
				for _, p in ipairs(player) do
					table.insert(playerNames, p.Name)
				end
				return table.concat(playerNames, ", ")
			end
			return player.Name
		end;
	})
end
