local FrozenPlayersModule = require(game:GetService("ServerScriptService"):FindFirstChild("Cmdr").Tables.Freeze)


return function (context, players)
	local moderator = context.Executor
	local moderatorName = moderator.Name
	local frozenMessage = ""

	for _, player in pairs(players) do
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")

		if humanoid and not FrozenPlayersModule.frozenPlayers[player.UserId] then
			humanoid.WalkSpeed = 0
			humanoid.JumpPower = 0
			humanoid:ChangeState(Enum.HumanoidStateType.Physics)
			FrozenPlayersModule.frozenPlayers[player.UserId] = true

			frozenMessage = frozenMessage .. player.Name .. " has been frozen by " .. moderatorName .. ".\n"
		else
			frozenMessage = frozenMessage .. player.Name .. " is already frozen or has no humanoid.\n"
		end
	end

	return frozenMessage
end
