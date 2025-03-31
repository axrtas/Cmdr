local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local warnDataStore = DataStoreService:GetDataStore("PlayerWarnings")
local warnEvent = ReplicatedStorage.Cmdr.Events:WaitForChild("WarnEvent")

local cooldowns = {}

return function(context, targetPlayer, message)
	local executor = context.Executor
	if not targetPlayer or not message or message == "" then
		return "Invalid player or message."
	end

	local playerId = targetPlayer.UserId
	local currentTime = tick()

	if cooldowns[playerId] and (currentTime - cooldowns[playerId]) < 10 then
		return "You must wait before warning this player again."
	end

	cooldowns[playerId] = currentTime

	local warnings = { count = 0, reasons = {} }
	local success, storedWarnings = pcall(function()
		return warnDataStore:GetAsync(tostring(playerId))
	end)

	if not success then
		return "Error retrieving warnings from DataStore."
	end

	if not storedWarnings then
		storedWarnings = { count = 0, reasons = {} }
	end

	table.insert(storedWarnings.reasons, message)

	storedWarnings.count = storedWarnings.count + 1

	local saveSuccess, err = pcall(function()
		warnDataStore:SetAsync(tostring(playerId), storedWarnings)
	end)

	if not saveSuccess then
		return "Error saving warnings to DataStore: " .. err
	end

	local warningsFolder = targetPlayer:FindFirstChild("WarningsFolder")
	if not warningsFolder then
		warningsFolder = Instance.new("Folder")
		warningsFolder.Name = "WarningsFolder"
		warningsFolder.Parent = targetPlayer
	end

	local warningReason = Instance.new("StringValue")
	warningReason.Name = "Warning" .. storedWarnings.count
	warningReason.Value = message
	warningReason.Parent = warningsFolder

	warnEvent:FireClient(targetPlayer, executor.Name, message)

	return targetPlayer.Name .. " has been warned. They now have " .. storedWarnings.count .. " warnings."
end
