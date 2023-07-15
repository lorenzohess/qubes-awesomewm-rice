local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local config = require("config")

local widgetsBin = config.dirs.widgetsBin
local theme = config.theme
local widget_colors = theme.widgets

-- Kernel version
-- Click tux to update hardcoded version value
local container_kernel_widget = wibox.container

local kernel_widget = wibox.widget {
    align = 'center', valign = 'center', widget = wibox.widget.textbox('')
}

local update_kernel_widget = function()
    local kernelCmd = "uname -r | cut -d. -f1,2"
    awful.spawn.easy_async_with_shell(kernelCmd, function(stdout, stderr, reason, exit_code)
        kernel_widget.text = ' ' .. stdout
    end, kernel_widget)
end

-- Update the kernel version value when you click the widget
kernel_widget:connect_signal("button::press", function() update_kernel_widget() end)

container_kernel_widget = {
    {
        { widget = kernel_widget },
        left = 8,
        right = 7,
        widget = wibox.container.margin
    },
    shape = gears.shape.rounded_bar,
    fg = widget_colors.kernel_fg,
    bg = widget_colors.bg,
    widget = wibox.container.background
}

-- Call this to actually show the value.
update_kernel_widget()

return container_kernel_widget

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
