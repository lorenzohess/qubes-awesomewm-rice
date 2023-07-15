local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")

beautiful.notification_shape = gears.shape.rounded_rect
naughty.config.defaults.ontop = true
naughty.config.padding = 3
naughty.config.spacing = 5
naughty.config.defaults.margin = 3
naughty.config.defaults.timeout = 3
naughty.config.defaults.border_width = 2

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
