return function(context, time)
	local function setTimeOfDay(timeString)
		local timeParts = {}
		for part in string.gmatch(timeString, "%d+") do
			table.insert(timeParts, tonumber(part))
		end

		if #timeParts == 2 then
			local hours = timeParts[1]
			local minutes = timeParts[2]

			if hours >= 0 and hours < 24 and minutes >= 0 and minutes < 60 then
				game.Lighting:SetMinutesAfterMidnight(hours * 60 + minutes)
				return true
			end
		end
		return false
	end

	local timeSet = false
	local successMessage = ""

	if time == "morning" then
		timeSet = setTimeOfDay("06:00")
		successMessage = "The time has been set to morning (06:00)."
	elseif time == "noon" then
		timeSet = setTimeOfDay("12:00")
		successMessage = "The time has been set to noon (12:00)."
	elseif time == "evening" then
		timeSet = setTimeOfDay("18:00")
		successMessage = "The time has been set to evening (18:00)."
	elseif setTimeOfDay(time) then
		successMessage = "The time has been set to " .. time .. "."
		timeSet = true
	else
		successMessage = "Invalid time format. Please use 'morning', 'noon', 'evening', or a valid time like '18:00'."
	end

	if timeSet then
		return successMessage
	else
		return successMessage
	end
end
