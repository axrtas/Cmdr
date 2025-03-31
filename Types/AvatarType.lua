return function (registry)
	registry:RegisterType("avatarType", registry.Cmdr.Util.MakeEnumType("AvatarType", {"R6", "R15"}, function(value)
		local lowerValue = tostring(value):lower()
		if lowerValue == "r6" then
			return "R6"
		elseif lowerValue == "r15" then
			return "R15"
		else
			return "Invalid avatar type. Use 'R6' or 'R15'."
		end
	end))
end
