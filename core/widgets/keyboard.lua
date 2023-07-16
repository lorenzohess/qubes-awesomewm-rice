local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local config = require("config")

local keyboardlayout = require("lib.keyboardlayout")
local theme = config.theme
local widget_colors = theme.widgets

local container_keyboard_widget = wibox.container

local keyboard_icon = wibox.widget.textbox('') -- 󰌌
-- The layout widget has a lot of padding so put a pipe and a space after it.
--local pipe_icon = wibox.widget.textbox('|')
local space = wibox.widget.textbox(' ')
local open_bracket = wibox.widget.textbox('[')
local close_bracket = wibox.widget.textbox(']')

local layout_widget = keyboardlayout()
local capslock_widget = require("core.widgets.capslock")

local container_keyboard_widget = {
    {
        {
            keyboard_icon,
            space,
            open_bracket,
            layout_widget,
            space,
            capslock_widget,
            close_bracket,
            layout = wibox.layout.fixed.horizontal
        },
        left = 9,
        right = 5,
        widget = wibox.container.margin
    },
    shape = gears.shape.rounded_bar,
    fg = widget_colors.keyboard_fg,
    bg = widget_colors.bg,
    widget = wibox.container.background
}

return container_keyboard_widget

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
