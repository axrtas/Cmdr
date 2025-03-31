local FrozenPlayersModule = require(game:GetService("ServerScriptService"):FindFirstChild("Cmdr").Tables.Freeze)

return function (context, players)
	local moderator = context.Executor
	local moderatorName = moderator.Name
	local unfrozenMessage = ""

	for _, player in pairs(players) do
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")

		if humanoid and FrozenPlayersModule.frozenPlayers[player.UserId] then
			humanoid.WalkSpeed = 17
			humanoid.JumpPower = 50
			humanoid:ChangeState(Enum.HumanoidStateType.Physics)
			FrozenPlayersModule.frozenPlayers[player.UserId] = nil

			unfrozenMessage = unfrozenMessage .. player.Name .. " has been unfrozen by " .. moderatorName .. ".\n"
		else
			unfrozenMessage = unfrozenMessage .. player.Name .. " is not frozen or has no humanoid.\n"
		end
	end

	return unfrozenMessage
end