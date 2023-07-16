local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local config = require("config")

local widgetsBin = config.dirs.widgetsBin
local theme = config.theme
local widget_colors = theme.widgets

local container_battery_widget = wibox.container

local battery_widget = wibox.widget {
    align = 'center', valign = 'center', widget = wibox.widget.textbox
}

local update_battery_widget = function(bat)
    battery_widget.text = bat
end

awful.widget.watch(widgetsBin .. "/battery.sh", 5, function(self, stdout)
    local bat = stdout
    update_battery_widget(bat)
end)

container_battery_widget = {
    {
        { widget = battery_widget },
        left = 8, 
        right = 6,
        widget = wibox.container.margin
    },
    shape = gears.shape.rounded_bar,
    fg = widget_colors.battery_fg,
    bg = widget_colors.bg,
    widget = wibox.container.background
}

return container_battery_widget 

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
