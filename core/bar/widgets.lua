local wibox = require("wibox")

-- We need to explicitly require the calendar widget and
-- datetime widget so we can connect them. Only the datetime
-- widget will be placed into the wibar.
local calendar_setup = require("core.widgets.calendar_setup")
local calendar_widget = calendar_setup()

local container_datetime_widget = require("core.widgets.datetime")
local datetime_widget = container_datetime_widget[1][1]["widget"]

datetime_widget:connect_signal("button::press", function(_, _, _, button)
      if button == 1 then calendar_widget.toggle() end
end)

-- Widgets table
local widgets = {
    battery = require("core.widgets.battery"),
    brightness = require("core.widgets.brightness"),
    clipboard = require("core.widgets.clipboard"),
    datetime = container_datetime_widget,
    kernel = require("core.widgets.kernel"),
    keyboard = require("core.widgets.keyboard"),
    qubecount = require("core.widgets.qubecount"),
    system = require("core.widgets.system.system"),
    systray = wibox.widget.systray(),
    qubes_menu = require("core.widgets.qubes_menu"),
    launcher = require("core.widgets.qubes_launcher"),
    -- Simple horizontal space widget
    space = wibox.widget.textbox(' '),
}

return widgets

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
