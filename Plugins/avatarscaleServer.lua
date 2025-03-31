return function(context, scale, targetPlayer)
	-- Ensure scale is provided and is a valid number
	if not scale or type(scale) ~= "number" then
		return "Invalid scale value. Please provide a valid number."
	end

	-- Validate scale value (within the range of 0.1 to 10)
	if scale < 0.1 or scale > 10 then
		return "Scale must be between 0.1 and 10."
	end

	-- If no targetPlayer is provided, use the executor (the player who ran the command)
	if not targetPlayer then
		targetPlayer = context.Executor
	end

	-- Ensure that targetPlayer is a valid Player object
	if not targetPlayer.Character then
		return "Player has no character."
	end

	-- Check if the player has a character
	local character = targetPlayer.Character
	if not character then
		return targetPlayer.Name .. " has no character."
	end

	-- Get the humanoid of the character
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return "No humanoid found in " .. targetPlayer.Name .. "'s character."
	end

	-- Modify the humanoid's body part scales
	local HS = humanoid:FindFirstChild("HeadScale")
	local BDS = humanoid:FindFirstChild("BodyDepthScale")
	local BWS = humanoid:FindFirstChild("BodyWidthScale")
	local BHS = humanoid:FindFirstChild("BodyHeightScale")

	-- Scale the values
	if HS then
		HS.Value = scale
	end
	if BDS then
		BDS.Value = scale
	end
	if BWS then
		BWS.Value = scale
	end
	if BHS then
		BHS.Value = scale
	end

	-- Return success message
	return targetPlayer.Name .. "'s avatar has been scaled to " .. scale
end
