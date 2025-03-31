return function(context, scale, targetPlayer)
	if not scale or type(scale) ~= "number" then
		return "Invalid scale value. Please provide a valid number."
	end

	if scale < 0.1 or scale > 10 then
		return "Scale must be between 0.1 and 10."
	end

	if not targetPlayer then
		targetPlayer = context.Executor
	end

	if not targetPlayer.Character then
		return "Player has no character."
	end

	local character = targetPlayer.Character
	if not character then
		return targetPlayer.Name .. " has no character."
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return "No humanoid found in " .. targetPlayer.Name .. "'s character."
	end

	local HS = humanoid:FindFirstChild("HeadScale")
	local BDS = humanoid:FindFirstChild("BodyDepthScale")
	local BWS = humanoid:FindFirstChild("BodyWidthScale")
	local BHS = humanoid:FindFirstChild("BodyHeightScale")

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

	return targetPlayer.Name .. "'s avatar has been scaled to " .. scale
end
