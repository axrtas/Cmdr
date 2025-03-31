local goTosFolder = game:GetService("Lighting"):FindFirstChild("GoTos")

return function (registry)
	if not goTosFolder then
		warn("The 'GoTos' folder does not exist in the workspace.")
		return
	end

	local locationNames = {}

	for _, location in pairs(goTosFolder:GetChildren()) do
		if location:IsA("BasePart") then
			table.insert(locationNames, location.Name)
		end
	end

	if #locationNames > 0 then
		registry:RegisterType("location", registry.Cmdr.Util.MakeEnumType("Location", locationNames))
	else
		warn("No valid locations found in 'GoTos' folder. Ensure it contains BasePart objects.")
	end
end
