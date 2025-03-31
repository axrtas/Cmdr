return function (context, message)
	if not message or message == "" then
		return "Please provide a valid message for the announcement."
	end

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local announcementEvent = ReplicatedStorage.Cmdr:WaitForChild("Events").AnnouncementEvent

	local executor = context.Executor
	local executorName = executor.Name
	local executorThumbnail = executor.Character and executor.Character:FindFirstChild("Head") and executor.Character.Head:FindFirstChild("face") or nil

	announcementEvent:FireAllClients(message, executorName, executorThumbnail and executorThumbnail.TextureId or "rbxassetid://12345678")  -- Use placeholder if no thumbnail

	return "Announcement sent to all players: " .. message
end
