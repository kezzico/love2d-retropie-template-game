function toboolean(value)
	if value then
		return value
	end

	return false
end

function tablelength(T)
	local count = 0

	for _ in pairs(T) do count = count + 1 end

	return count
end
  
function string:split (sep)
    local sep, fields = sep or ":", {}

	local pattern = string.format("([^%s]+)", sep)

	self:gsub(pattern, function(c) fields[#fields+1] = c end)

	return fields
end
