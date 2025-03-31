return function(context, avatarType, targetPlayer)
	if not targetPlayer then
		targetPlayer = context.Executor
	end

	if not targetPlayer.Character then
		return targetPlayer.Name .. " has no character."
	end

	local character = targetPlayer.Character
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		if avatarType == "R6" then
			if humanoid.RigType ~= Enum.HumanoidRigType.R6 then
				local description = game.Players:GetHumanoidDescriptionFromUserId(targetPlayer.UserId)
				local morph = game.Players:CreateHumanoidModelFromDescription(description, Enum.HumanoidRigType.R6)
				morph:SetPrimaryPartCFrame(character.PrimaryPart.CFrame)
				morph.Name = targetPlayer.Name
				targetPlayer.Character = morph
				morph.Parent = workspace
				return targetPlayer.Name .. "'s avatar has been switched to R6."
			else
				return targetPlayer.Name .. " already has an R6 avatar."
			end
		elseif avatarType == "R15" then
			if humanoid.RigType ~= Enum.HumanoidRigType.R15 then
				local description = game.Players:GetHumanoidDescriptionFromUserId(targetPlayer.UserId)
				local morph = game.Players:CreateHumanoidModelFromDescription(description, Enum.HumanoidRigType.R15)
				morph:SetPrimaryPartCFrame(character.PrimaryPart.CFrame)
				morph.Name = targetPlayer.Name
				targetPlayer.Character = morph
				morph.Parent = workspace
				return targetPlayer.Name .. "'s avatar has been switched to R15."
			else
				return targetPlayer.Name .. " already has an R15 avatar."
			end
		else
			return "Invalid avatar type. Use 'R6' or 'R15'."
		end
	end

	return "Humanoid not found in the character."
end
