local ToolFolder = game:GetService("Lighting"):FindFirstChild("Tools")

if not ToolFolder then
	warn("The 'ServerStorage' service does not exist.")
else
end

return function(registry)
	if not ToolFolder then
		warn("The 'ServerStorage' does not exist.")
		return
	end

	local ToolNames = {}

	for _, item in pairs(ToolFolder:GetChildren()) do
		if item:IsA("Tool") then
			table.insert(ToolNames, item.Name)
		else
			print("Found a non-tool object:", item.Name)
		end
	end

	-- If tools are found, register them with Cmdr
	if #ToolNames > 0 then
		local toolsEnum = registry.Cmdr.Util.MakeEnumType("Tool", ToolNames)
		registry:RegisterType("tools", toolsEnum)
	else
		warn("No valid tools found in 'ServerStorage'.")
	end
end
