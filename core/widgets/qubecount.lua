local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local config = require("config")

local widgetsBin = config.dirs.widgetsBin
local theme = config.theme
local widget_colors = theme.widgets

-- Qube count
local container_qubecount_widget = wibox.container

local qubecount_widget = wibox.widget {
    align = 'center', valign = 'center', widget = wibox.widget.textbox
}

local update_qubecount_widget = function(data)
    qubecount_widget.text = data
end

awful.widget.watch(widgetsBin .. "/qube-count.sh", 15, function(self, stdout)
    local data = stdout
    update_qubecount_widget(data)
end)

container_qubecount_widget = {
    {
        { widget = qubecount_widget },
        left = 8, 
        right = 5,
        widget = wibox.container.margin
    },
    shape = gears.shape.rounded_bar,
    fg = widget_colors.qubecount_fg,
    bg = widget_colors.bg,
    widget = wibox.container.background
}

return container_qubecount_widget

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
