local awful = require("awful")
local gears = require("gears")
local theme = require("config").theme

-- Make tasklist buttons
return gears.table.join(
awful.button({}, 1, function(c)
    if c == client.focus then
        c.minimized = true
    else
        c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
        )
    end
end),
awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = my_theme.menu_width } })
end),
awful.button({}, 4, function() -- scroll up
    awful.client.focus.byidx(1)
end),
awful.button({}, 5, function() -- scroll down
    awful.client.focus.byidx(-1)
end)
)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
