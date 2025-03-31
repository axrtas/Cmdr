return function (context, recipient, message)
	if not message or message == "" then
		return "You must provide a message."
	end

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local pmEvent = ReplicatedStorage.Cmdr.Events:FindFirstChild("PMEvent")

	local sender = context.Executor
	local senderName = sender.Name

	if recipient == "all" then
		for _, player in pairs(game:GetService("Players"):GetPlayers()) do
			if player ~= sender then
				pmEvent:FireClient(player, senderName, message)
			end
		end
		return "PM sent to all players: " .. message
	elseif typeof(recipient) == "Instance" and recipient:IsA("Player") then
		pmEvent:FireClient(recipient, senderName, message)
		return "PM sent to " .. recipient.Name .. ": " .. message
	else
		return "Invalid recipient. Use a player's name or 'all'."
	end
end
