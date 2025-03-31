return function (context, message)
	if not message or message == "" then
		return "Please provide a valid message for the announcement."
	end

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local announcementEvent = ReplicatedStorage.Cmdr:WaitForChild("Events").AnnouncementEvent

	-- Get executor's information (the person who runs the command)
	local executor = context.Executor
	local executorName = executor.Name
	local executorThumbnail = executor.Character and executor.Character:FindFirstChild("Head") and executor.Character.Head:FindFirstChild("face") or nil

	-- Fire the event to all players with the message and executor's data
	announcementEvent:FireAllClients(message, executorName, executorThumbnail and executorThumbnail.TextureId or "rbxassetid://12345678")  -- Use placeholder if no thumbnail

	return "Announcement sent to all players: " .. message
end
