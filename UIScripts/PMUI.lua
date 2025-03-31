local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local pmEvent = ReplicatedStorage.Cmdr.Events:FindFirstChild("PMEvent")

pmEvent.OnClientEvent:Connect(function(senderName, message)
	local playerGui = player:FindFirstChild("PlayerGui")
	local pmGui = playerGui:FindFirstChild("CmdrUI").PMGUI  

	if pmGui then
		local mainFrame = pmGui:FindFirstChild("Main")
		local Sound = mainFrame:FindFirstChild("Sound")
		local senderImage = mainFrame:FindFirstChild("PlayerThumbnail")
		local senderNameLabel = mainFrame:FindFirstChild("ExecutorName")
		local messageLabel = mainFrame:FindFirstChild("TextLabel")

		senderNameLabel.Text = senderName
		messageLabel.Text = message

		local sender = Players:FindFirstChild(senderName)
		if sender then
			local success, headshot = pcall(function()
				return Players:GetUserThumbnailAsync(sender.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			end)

			if success then
				senderImage.Image = headshot
			else
				senderImage.Image = "rbxassetid://12345678"
			end
		else
			senderImage.Image = "rbxassetid://12345678"
		end

		pmGui.Enabled = true

		-- Start position off-screen on the right
		mainFrame.Position = UDim2.new(1, 50, 1, -mainFrame.Size.Y.Offset - 50)

		-- Animate to the bottom-right corner
		mainFrame:TweenPosition(UDim2.new(0.85, 0, 1, -mainFrame.Size.Y.Offset - 50), "Out", "Quad", 0.5, true)

		Sound:Play()

		wait(5)

		-- Animate back to the right side, off-screen
		mainFrame:TweenPosition(UDim2.new(1, 50, 1, -mainFrame.Size.Y.Offset - 50), "In", "Quad", 0.5, true)

		wait(0.5)  -- Wait for animation to finish
		pmGui.Enabled = false
	end
end)
