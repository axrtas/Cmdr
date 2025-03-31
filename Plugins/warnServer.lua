local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local warnDataStore = DataStoreService:GetDataStore("PlayerWarnings") -- DataStore for storing warnings and reasons
local warnEvent = ReplicatedStorage.Cmdr.Events:WaitForChild("WarnEvent")

local cooldowns = {}  -- To store cooldown times for players

-- Function to handle the warn command
return function(context, targetPlayer, message)
	local executor = context.Executor
	if not targetPlayer or not message or message == "" then
		return "Invalid player or message."
	end

	-- Check cooldown for warning (to avoid spamming warnings on a player)
	local playerId = targetPlayer.UserId
	local currentTime = tick()

	-- Ensure there is a cooldown of 10 seconds before warning the same player again
	if cooldowns[playerId] and (currentTime - cooldowns[playerId]) < 10 then
		return "You must wait before warning this player again."
	end

	-- Update cooldown time
	cooldowns[playerId] = currentTime

	-- Get the warning count and reasons from DataStore
	local warnings = { count = 0, reasons = {} }
	local success, storedWarnings = pcall(function()
		return warnDataStore:GetAsync(tostring(playerId)) -- Get the data for the player
	end)

	-- Check if there was an error getting the data
	if not success then
		return "Error retrieving warnings from DataStore."
	end

	-- If no data is returned, initialize it
	if not storedWarnings then
		storedWarnings = { count = 0, reasons = {} }
	end

	-- Add the new reason to the warnings list in the DataStore
	table.insert(storedWarnings.reasons, message)

	-- Increase the warning count
	storedWarnings.count = storedWarnings.count + 1

	-- Update the DataStore with the new warning count and reasons
	local saveSuccess, err = pcall(function()
		warnDataStore:SetAsync(tostring(playerId), storedWarnings)
	end)

	if not saveSuccess then
		return "Error saving warnings to DataStore: " .. err
	end

	-- Add a StringValue to the player’s warnings folder in their Player object
	local warningsFolder = targetPlayer:FindFirstChild("WarningsFolder")
	if not warningsFolder then
		warningsFolder = Instance.new("Folder")
		warningsFolder.Name = "WarningsFolder"
		warningsFolder.Parent = targetPlayer
	end

	-- Create a new StringValue with the warning reason
	local warningReason = Instance.new("StringValue")
	warningReason.Name = "Warning" .. storedWarnings.count  -- Name the StringValue for clarity
	warningReason.Value = message
	warningReason.Parent = warningsFolder

	-- Fire the event to display the warning message on the client side
	warnEvent:FireClient(targetPlayer, executor.Name, message)

	return targetPlayer.Name .. " has been warned. They now have " .. storedWarnings.count .. " warnings."
end
