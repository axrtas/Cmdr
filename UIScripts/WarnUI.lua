
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local warnEvent = ReplicatedStorage:WaitForChild("Cmdr").Events:WaitForChild("WarnEvent")

warnEvent.OnClientEvent:Connect(function(adminName, message)
	local playerGui = player:FindFirstChild("PlayerGui")
	local warnGui = playerGui.CmdrUI:FindFirstChild("WarnGUI")

	if warnGui then
		local mainFrame = warnGui:FindFirstChild("Main")
		local adminLabel = mainFrame:FindFirstChild("ExecutorName")
		local adminImage = mainFrame:FindFirstChild("PlayerThumbnail")
		local messageLabel = mainFrame:FindFirstChild("TextLabel")
		local countdownLabel = mainFrame:FindFirstChild("Countdown")
		local sound = mainFrame:FindFirstChild("Sound")

		adminLabel.Text = adminName
		messageLabel.Text = message

		-- Thumbnail
		local admin = Players:FindFirstChild(adminName)
		if admin then
			local success, headshot = pcall(function()
				return Players:GetUserThumbnailAsync(admin.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			end)

			if success then
				adminImage.Image = headshot
			else
				adminImage.Image = "rbxassetid://12345678"
			end
		else
			adminImage.Image = "rbxassetid://12345678"
		end
		warnGui.Enabled = true

		mainFrame.Position = UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 1, 0)

		mainFrame:TweenPosition(UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 0.5, -mainFrame.Size.Y.Offset / 2), "Out", "Quad", 0.5, true)

		sound:Play()

		local countdownTime = 10
		while countdownTime > 0 do
			countdownLabel.Text = string.format("%.1f", countdownTime)

			wait(0.1)
			countdownTime = countdownTime - 0.1
		end

		mainFrame:TweenPosition(UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 1, 0), "In", "Quad", 0.5, true)

		wait(0.5)
		warnGui.Enabled = false
	end
end)
