local wibox = require("wibox")
local gears = require("gears")

local theme = require("config").theme

local helpers = {}

-- Return a widget with left-aligned text and a right-aligned icon to serve as
-- an entry in the system popup.
local function text_with_icon(text, icon)
    return wibox.widget {
        {
            font = theme.sys_popup_font,
            widget = wibox.widget.textbox(text),
        },
        {
            -- middle widget is minimum space between text and icon
            font = theme.sys_popup_font,
            widget = wibox.widget.textbox('  '),
        },
        {
            {
                halign = "center",
                font = theme.sys_popup_font,
                widget = wibox.widget.textbox(icon)
            },
            widget = wibox.container.background
        }, 
        layout = wibox.layout.align.horizontal
    }
end

helpers.text_with_icon = text_with_icon

return helpers

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
