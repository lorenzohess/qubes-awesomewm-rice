-- From some forum post

function dump(table)
	if type(table) == 'table' then
		local s = '{\n'
		for k, v in pairs(table) do
			if type(k) ~= 'number' then
				if type(k) ~= 'function' then
					if type(k) ~= 'table' then k = '"' ..k.. '"' end
				end
			end
			s = s .. '[' .. tostring(k) .. '] = ' .. dump(v) .. ','
		end
		return s .. '} '
	else
		return tostring(table)
	end
end

return dump
