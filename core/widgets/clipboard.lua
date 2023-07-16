local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local config = require("config")

local widgetsBin = config.dirs.widgetsBin
local theme = config.theme
local widget_colors = theme.widgets

-- Clipboard status
local container_clipboard_widget = wibox.container

local clipboard_widget = wibox.widget {
    align = 'center', valign = 'center', widget = wibox.widget.textbox
}

local update_clipboard_widget = function(data)
    clipboard_widget.text = data
end

local qc, qc_signal = awful.widget.watch(widgetsBin .. "/clipboard.sh", 3, function(self, stdout)
    local data = stdout
    update_clipboard_widget(data)
end)

container_clipboard_widget = {
    {
        { widget = clipboard_widget },
        left = 8,
        right = 5,
        widget = wibox.container.margin
    },
    shape = gears.shape.rounded_bar,
    fg = widget_colors.clipboard_fg,
    bg = widget_colors.bg,
    widget = wibox.container.background
}

return container_clipboard_widget

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
