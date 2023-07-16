local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local theme = require("config").theme
local widget_colors = theme.widgets
local text_with_icon = require("core.widgets.system.helpers").text_with_icon

local screenlock = require("core.widgets.system.screenlock")

-- Buttons and Indicators
local logout_button = text_with_icon("<i>Logout</i>", '󰍃')
local poweroff_button = text_with_icon("<i>Shutdown</i>", '')

-- Button functions
local logout = function() awful.spawn("awesome-client 'awesome.quit()'") end
local poweroff = function() awful.spawn("sudo shutdown now") end

logout_button:connect_signal("button::release", function(_, _, _, button) if button == 1 then logout() end end)
poweroff_button:connect_signal("button::release", function(_, _, _, button) if button == 1 then logout() end end)

-- Popup
local popup = awful.popup {
    ontop = true,
    visible = false,
    shape = gears.shape.rounded_rect,
    border_width = theme.sys_popup_border_width,
    border_color = theme.sys_popup_border_color,
    maximum_width = 600,
    maximum_height = 600,
    offset = { y = 5 },
    widget = {}
}

local show_popup = function()
    if popup.visible then
        popup.visible = not popup.visible
    else
        screenlock.update_icon()
        popup:move_next_to(mouse.current_widget_geometry)
    end
end

popup:setup {
    left = 2,
    right = 4,
    {
        {
            logout_button,
            poweroff_button,
            screenlock.lock_button,
            screenlock.status_button,
            layout = wibox.layout.fixed.vertical
        },
        fg = theme.sys_popup_fg,
        bg = theme.sys_popup_bg,
        layout = wibox.container.background
    },
    widget = wibox.container.margin
}

local system_widget = wibox.widget {
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox('')
}

local container_system_widget = {
    {
        system_widget,
        left = 7,
        right = 7,
        widget = wibox.container.margin
    },
    shape = gears.shape.rounded_bar,
    fg = widget_colors.system_fg,
    bg = widget_colors.bg,
    widget = wibox.container.background
}

system_widget:connect_signal("button::press", function() show_popup() end)

return container_system_widget

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
