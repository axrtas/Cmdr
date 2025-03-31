return function (context, message)
	-- If no message is provided, hide the header (or return nothing)
	if not message or message == "" then
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local headerEvent = ReplicatedStorage.Cmdr:WaitForChild("Events").HeaderEvent

		headerEvent:FireAllClients("", "", "")
		return "Hint has been cleared."
	end

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local headerEvent = ReplicatedStorage.Cmdr:WaitForChild("Events").HeaderEvent

	-- Get executor's information (the person who runs the command)
	local executor = context.Executor

	-- Fire the event to all players with the message and executor's data
	headerEvent:FireAllClients(message)

	return "Hint sent to all players: " .. message
end
