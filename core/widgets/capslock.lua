local awful = require("awful")
local wibox = require("wibox")

local theme = require("config").theme

-- If you want to use 'a' and 'A', for example, change it here.
local capslock_inactive_icon = '󰘲'
local capslock_active_icon = '󰘲'

local capslock_status = wibox.widget {
    halign = 'center',
    markup = capslock_inactive_icon, -- assume inactive at startup
    widget = wibox.widget.textbox
}

awful.widget.watch("xset q", 1, function(widget, stdout, stderr, exit_reason, exit_code)
    for line in stdout:gmatch("[^\r\n]+") do
        if line:match("Caps Lock") then
            local status = string.match(line, "Caps Lock:%s+(%l+)")
            if status == 'off' then
                capslock_status.markup = '<span foreground="' .. theme.widgets.capslock_off .. '">' .. capslock_inactive_icon .. '</span>'
            else
                capslock_status.markup = '<span foreground="' .. theme.widgets.capslock_on .. '">' .. capslock_inactive_icon .. '</span>'
            end
        end
    end
end)

return capslock_status

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
