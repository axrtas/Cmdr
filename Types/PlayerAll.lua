local Players = game:GetService("Players")

return function (registry)
	-- Define the player type
	local playerType = {
		Transform = function (text)
			-- If the input is "all", return all players
			if text:lower() == "all" then
				return Players:GetPlayers()
			end

			-- Otherwise, search for a specific player by name
			local foundPlayers = {}
			for _, player in ipairs(Players:GetPlayers()) do
				if player.Name:lower():find(text:lower(), 1, true) then
					table.insert(foundPlayers, player)
				end
			end
			return foundPlayers
		end;

		Validate = function (players)
			-- If players is empty, or "all" was used, then there's no validation needed
			if #players == 0 then
				return false, "No player with that name could be found."
			end
			return true
		end;

		Autocomplete = function (players)
			-- Return the list of player names for autocomplete
			local names = {}
			for _, player in ipairs(players) do
				table.insert(names, player.Name)
			end
			return names
		end;

		Parse = function (players)
			-- Return the first player in the list or "all" if all players are intended
			if #players == 1 and players[1] == "all" then
				return Players:GetPlayers()  -- Return all players if "all" was used
			end
			return players[1]  -- Return the first player if not
		end;

		Default = function(player)
			-- If it's a list of players, just join their names into a string
			if type(player) == "table" then
				local playerNames = {}
				for _, p in ipairs(player) do
					table.insert(playerNames, p.Name)
				end
				return table.concat(playerNames, ", ")
			end
			return player.Name  -- Return the player's name
		end;
	}

	-- Register player and players types with Cmdr
	registry:RegisterType("playerall", playerType)
	registry:RegisterType("playersall", {
		Transform = function (text)
			-- If the input is "all", return all players
			if text:lower() == "all" then
				return Players:GetPlayers()
			end

			-- Otherwise, search for a specific player by name
			local foundPlayers = {}
			for _, player in ipairs(Players:GetPlayers()) do
				if player.Name:lower():find(text:lower(), 1, true) then
					table.insert(foundPlayers, player)
				end
			end
			return foundPlayers
		end;

		Validate = function (players)
			-- If players is empty, or "all" was used, then there's no validation needed
			if #players == 0 then
				return false, "No player with that name could be found."
			end
			return true
		end;

		Autocomplete = function (players)
			-- Return the list of player names for autocomplete
			local names = {}
			for _, player in ipairs(players) do
				table.insert(names, player.Name)
			end
			return names
		end;

		Parse = function (players)
			-- Return the first player in the list or "all" if all players are intended
			if #players == 1 and players[1] == "all" then
				return Players:GetPlayers()  -- Return all players if "all" was used
			end
			return players[1]  -- Return the first player if not
		end;

		Default = function(player)
			-- If it's a list of players, just join their names into a string
			if type(player) == "table" then
				local playerNames = {}
				for _, p in ipairs(player) do
					table.insert(playerNames, p.Name)
				end
				return table.concat(playerNames, ", ")
			end
			return player.Name  -- Return the player's name
		end;
	})
end
