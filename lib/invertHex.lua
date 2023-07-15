module = {}

local base16 = {
    ['0'] = 'F',
    ['1'] = 'E',
    ['2'] = 'D',
    ['3'] = 'C',
    ['4'] = 'B',
    ['5'] = 'A',
    ['6'] = '9',
    ['7'] = '8',
    ['8'] = '7',
    ['9'] = '6',
    ['A'] = '5',
    ['B'] = '4',
    ['C'] = '3',
    ['D'] = '2',
    ['E'] = '1',
    ['F'] = '0',
}

local split = function(input, sep)
    -- Split input string into list of characters for given separator.
    local t = {}
    if sep == nil then
        return {input}
    elseif sep == '' then
        for str in string.gmatch(input, "([^.])") do
            table.insert(t, str)
        end
    else
        for str in string.gmatch(input, '([^' .. sep .. ']+)') do
            table.insert(t, str)
        end
    end
    return t
end

local invert = function(hex, bw)
    -- https://stackoverflow.com/a/35970186

    -- Check if hex starts with hash or not
    if string.sub(hex, 1, 1) == '#' then
        hex = string.sub(hex, 2)
    end

    -- Split the hex into a list of chars
    local splitHex = split(hex, '')

    -- Invert each char with the base16 map
    local inverted = ''
    for _, v in ipairs(splitHex) do
        inverted = inverted .. base16[string.upper(tostring(v))]
    end

    -- If we just want black or white, use the
    -- formula below with the '> 186' standard.
    if (bw) then
        -- Split the inverted hex into chars
        -- and construct its rgb values.
        local splitRGB = split(inverted, '')
        local r = tonumber(splitRGB[1] .. splitRGB[2], 16)
        local g = tonumber(splitRGB[3] .. splitRGB[4], 16)
        local b = tonumber(splitRGB[5] .. splitRGB[6], 16)

        -- See stackoverflow post
        if (r * 0.299 + g * 0.587 + b * 0.114) > 186 then
            return "#dfdcd7" -- white
        else
            return "#000000" -- black
        end
    end

    return '#' .. inverted
end

module.invert = invert

return module

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
