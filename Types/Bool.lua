return function (registry)
	registry:RegisterType("bool", registry.Cmdr.Util.MakeEnumType("Boolean", {"true", "false"}, function(value)
		local lowerValue = tostring(value):lower()
		if lowerValue == "true" then
			return true
		elseif lowerValue == "false" then
			return false
		else
			error("Invalid boolean value. Use 'true' or 'false'.")
		end
	end))
end
