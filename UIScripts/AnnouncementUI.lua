local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local announcementEvent = ReplicatedStorage.Cmdr.Events:WaitForChild("AnnouncementEvent")

local countdownRunning = false
local currentCountdownTime = 0
local countdownLabel

announcementEvent.OnClientEvent:Connect(function(message, executorName)
	local playerGui = player.PlayerGui
	local announcementGui = playerGui:FindFirstChild("CmdrUI").AnnoucementGUI

	if announcementGui then
		local mainFrame = announcementGui:FindFirstChild("Main")
		local Sound = mainFrame.Sound
		local executorImage = mainFrame:FindFirstChild("PlayerThumbnail")
		local executorNameLabel = mainFrame:FindFirstChild("ExecutorName")
		local messageLabel = mainFrame:FindFirstChild("TextLabel")
		local executorRankLabel = mainFrame:FindFirstChild("ExecutorRank")
		countdownLabel = mainFrame:FindFirstChild("Countdown")

		local executor = Players:FindFirstChild(executorName)
		if executor then
			local executorUserId = executor.UserId
			local success, thumbnail = pcall(function()
				return Players:GetUserThumbnailAsync(executorUserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size420x420)
			end)

			if success then
				executorImage.Image = thumbnail
			else
				executorImage.Image = "rbxassetid://12345678"
			end

			local groupId = 33918224
			local rank = "Guest"
			local success, rankInGroup = pcall(function()
				return executor:GetRankInGroup(groupId)
			end)

			if success then
				if rankInGroup > 0 then
					rank = executor:GetRoleInGroup(groupId)
				end
			end

			if executorRankLabel then
				executorRankLabel.Text = rank
			end
		else
			executorImage.Image = "rbxassetid://12345678"
			if executorRankLabel then
				executorRankLabel.Text = "No Group"
			end
		end

		if executorNameLabel then
			executorNameLabel.Text = executorName
		end

		if messageLabel then
			messageLabel.Text = message
		end

		announcementGui.Enabled = true

		mainFrame.Position = UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 0, -mainFrame.Size.Y.Offset)

		mainFrame:TweenPosition(UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 0, 100), "Out", "Quad", 0.5, true)
		
		Sound:play()

		if countdownRunning then
			countdownRunning = false
			wait(1)
		end

		local messageLength = #message
		local countdownTime = math.max(4, messageLength * 0.08)

		countdownTime = math.min(countdownTime, 40)

		countdownRunning = true
		local remainingTime = countdownTime

		while remainingTime > 0 and countdownRunning do
			local seconds = math.floor(remainingTime)
			local fraction = (remainingTime - seconds) * 10
			local formattedTime = string.format("%d.%d", seconds, math.floor(fraction))

			if countdownLabel then
				countdownLabel.Text = formattedTime
			end

			remainingTime = remainingTime - 0.1
			wait(0.1)
		end

		if countdownLabel then
			countdownLabel.Text = "0.0"
		end
		mainFrame:TweenPosition(UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 0, -mainFrame.Size.Y.Offset), "In", "Quad", 0.5, true)
		wait(0.5)

		announcementGui.Enabled = false
	else
		warn("Announcement GUI not found!")
	end
end)
