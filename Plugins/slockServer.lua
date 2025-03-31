local Players = game:GetService("Players")

local serverLocked = true
local GROUP_ID = 33918224
local REQUIRED_RANK = 2

local playerAddedConnection

local function onPlayerAdded(player)
	if serverLocked and player:GetRankInGroup(GROUP_ID) < REQUIRED_RANK then
		player:Kick("Roleve® | This server is currently locked.")
	end
end

return function(context, enabled)
	local enabledStr = tostring(enabled):lower()

	if enabledStr == "true" then
		if serverLocked then
			return "The server is already locked."
		end
		serverLocked = true
	elseif enabledStr == "false" then
		if not serverLocked then
			return "The server is already open."
		end
		serverLocked = false
	else
		return "Invalid argument. Please use true or false to lock/unlock the server."
	end

	local executor = context.Executor
	if executor:GetRankInGroup(GROUP_ID) < REQUIRED_RANK then
		return "You do not have permission to lock/unlock the server."
	end

	if serverLocked then
		playerAddedConnection = Players.PlayerAdded:Connect(onPlayerAdded)
	else
		if playerAddedConnection then
			playerAddedConnection:Disconnect()
			playerAddedConnection = nil
		end
	end

	return serverLocked and "The server is now locked." or "The server is now open."
end
