-- Client-Side Script: Handles UI display, animations, and countdown for warning

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
		local countdownLabel = mainFrame:FindFirstChild("Countdown") -- Countdown Label
		local sound = mainFrame:FindFirstChild("Sound")

		-- Update the labels with the executor's name and message
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
		-- Show the warning GUI
		warnGui.Enabled = true

		-- Start position off-screen
		mainFrame.Position = UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 1, 0)

		-- Animate to the center
		mainFrame:TweenPosition(UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 0.5, -mainFrame.Size.Y.Offset / 2), "Out", "Quad", 0.5, true)

		-- Play sound
		sound:Play()

		-- Countdown Timer (5 seconds)
		local countdownTime = 10
		while countdownTime > 0 do
			-- Display the countdown with one decimal place
			countdownLabel.Text = string.format("%.1f", countdownTime)

			wait(0.1)  -- Wait for 0.1 seconds
			countdownTime = countdownTime - 0.1
		end

		-- After countdown finishes, hide the warning
		mainFrame:TweenPosition(UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 1, 0), "In", "Quad", 0.5, true)

		wait(0.5)  -- Wait for animation to finish
		warnGui.Enabled = false
	end
end)
