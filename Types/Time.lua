return function(registry)
	registry:RegisterType("time", registry.Cmdr.Util.MakeEnumType("Time", {
		"morning", 
		"noon", 
		"evening"
	}, function(value)
		local timeParts = {}
		if string.match(value, "^%d%d:%d%d$") then
			for part in string.gmatch(value, "%d+") do
				table.insert(timeParts, tonumber(part))
			end
			if #timeParts == 2 and timeParts[1] >= 0 and timeParts[1] < 24 and timeParts[2] >= 0 and timeParts[2] < 60 then
				return value
			else
				error("Invalid time format. Ensure hours are between 00 and 23 and minutes are between 00 and 59.")
			end
		else
			local predefinedTimes = {"morning", "noon", "evening"}
			for _, predefined in ipairs(predefinedTimes) do
				if string.lower(value) == predefined then
					return predefined
				end
			end
			error("Invalid time value. Use 'morning', 'noon', 'evening', or a custom time like '18:30'.")
		end
	end))
end
