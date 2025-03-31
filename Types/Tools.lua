local ToolFolder = game:GetService("Lighting"):FindFirstChild("Tools")

-- Check if ServerStorage exists (though it always should in Roblox)
if not ToolFolder then
	warn("The 'ServerStorage' service does not exist.")
else
end

return function(registry)
	-- Ensure ToolFolder is valid
	if not ToolFolder then
		warn("The 'ServerStorage' does not exist.")
		return
	end

	local ToolNames = {}

	-- Loop through all items in ServerStorage and find tools
	for _, item in pairs(ToolFolder:GetChildren()) do
		if item:IsA("Tool") then
			-- Add tool names to ToolNames list
			table.insert(ToolNames, item.Name)
		else
			-- Debugging: Log non-tool objects in ServerStorage
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
