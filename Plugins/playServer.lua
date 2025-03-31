local playerSounds = {}

return function(context, audioId, looped)
	local player = context.Executor

	if playerSounds[player] then
		playerSounds[player]:Stop()
		playerSounds[player]:Destroy()
	end

	if not audioId or audioId == "" then
		return "Stopped the music."
	end
	
	

	-- Create a new sound instance
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. audioId
	sound.Parent = workspace
	sound.Name = "CmdrSound"

	if looped == "false" then
		sound.Looped = false
	elseif looped == "true" then
		sound.Looped = true
	else
		sound.Looped = false
	end	
	sound:Play()

	playerSounds[player] = sound

	return ("Playing Music ID: %s"):format(audioId)
end
