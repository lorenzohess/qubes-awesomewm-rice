local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local config = require("config")

local widgetsBin = config.dirs.widgetsBin
local theme = config.theme
local widget_colors = theme.widgets

-- Brightness level
local container_brightness_widget = wibox.container

local brightness_widget = wibox.widget {
    align = 'center', valign = 'center', widget = wibox.widget.textbox
}

local update_brightness_widget = function(brightness)
    brightness_widget.text = brightness
end

awful.widget.watch(widgetsBin .. "/brightness.sh", 2, function(self, stdout)
    local brightness = stdout
    update_brightness_widget(brightness)
end)

container_brightness_widget = {
    {
        { widget = brightness_widget },
        left = 6,
        right = 6,
        widget = wibox.container.margin
    },
    shape = gears.shape.rounded_bar,
    fg = widget_colors.brightness_fg,
    bg = widget_colors.bg,
    widget = wibox.container.background
}

return container_brightness_widget

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
