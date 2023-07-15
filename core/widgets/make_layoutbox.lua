local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local function make_layoutbox(screen)
    -- Create an imagebox widget which will contain an icon
    -- indicating which layout we're using.
    -- We need one layoutbox per screen
    screen.layoutbox = awful.widget.layoutbox(screen)
    screen.layoutbox:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))

    local layoutbox_widget = wibox.widget({
        screen.layoutbox,
        right = 5,
        widget = wibox.container.margin
    })

    return layoutbox_widget
end

return make_layoutbox

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
