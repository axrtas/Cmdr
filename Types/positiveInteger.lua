return function(registry)
	registry:RegisterType("positiveInteger", {
		Transform = function(text)
			local num = tonumber(text)
			if num and num > 0 and math.floor(num) == num then
				return math.floor(num)
			end
			return nil, "Invalid distance. Please enter a positive whole number."
		end;
		Validate = function(value)
			return type(value) == "number" and value > 0
		end;
		Autocomplete = function()
			return {"5", "10", "15", "20"}
		end;
	})
end
