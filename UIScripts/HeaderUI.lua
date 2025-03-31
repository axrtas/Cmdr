local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local headerEvent = ReplicatedStorage.Cmdr.Events:WaitForChild("HeaderEvent")

headerEvent.OnClientEvent:Connect(function(message, executorName)
	local playerGui = player.PlayerGui
	local headerGui = playerGui:FindFirstChild("CmdrUI") and playerGui.CmdrUI:FindFirstChild("HeaderGUI")

	if headerGui then
		local mainFrame = headerGui:FindFirstChild("Main")
		local messageLabel = mainFrame:FindFirstChild("TextLabel")

		if message == "" then
				headerGui.Enabled = false
				if messageLabel then
					messageLabel.Text = ""
				end
		else
			if messageLabel then
				messageLabel.Text = message
			end
			headerGui.Enabled = true

		end
	else
		warn("Header GUI not found!")
	end
end)
