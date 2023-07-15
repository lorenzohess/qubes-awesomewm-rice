local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local config = require("config")

local widgetsBin = config.dirs.widgetsBin
local theme = config.theme
local widget_colors = theme.widgets

-- Datetime icon, with calendar toggle
local container_datetime_widget = wibox.container

local datetime_widget = wibox.widget {
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local update_datetime_widget = function(stdout)
    datetime_widget.text = stdout
end

local datetime, datetime_signal = awful.widget.watch(widgetsBin .. "/datetime.sh", 3, function(self, stdout)
    local datetime = stdout
    update_datetime_widget(datetime)
end)

-- Datetime container
container_datetime_widget = {
    {
        { widget = datetime_widget },
        left = 9,
        right = 7,
        widget = wibox.container.margin
    },
    shape = gears.shape.rounded_bar,
    fg = widget_colors.datetime_fg,
    bg = widget_colors.bg,
    widget = wibox.container.background
}

return container_datetime_widget

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
