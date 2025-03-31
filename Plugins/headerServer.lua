return function (context, message)
	if not message or message == "" then
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local headerEvent = ReplicatedStorage.Cmdr:WaitForChild("Events").HeaderEvent

		headerEvent:FireAllClients("", "", "")
		return "Hint has been cleared."
	end

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local headerEvent = ReplicatedStorage.Cmdr:WaitForChild("Events").HeaderEvent

	local executor = context.Executor

	headerEvent:FireAllClients(message)

	return "Hint sent to all players: " .. message
end
