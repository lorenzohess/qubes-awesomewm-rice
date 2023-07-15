local naughty = require("naughty")
local gears = require("gears")

local msg = function(message)
	naughty.notify { text = "Message: " .. message, shape = gears.shape.rounded_rect }
end

return msg

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
