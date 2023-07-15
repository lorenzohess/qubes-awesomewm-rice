local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local qubes_tasklist = require("lib.qubes_tasklist")

local function make_tasklist(screen)
    screen.mytasklist = qubes_tasklist({
        screen          = screen,
        filter          = awful.widget.tasklist.filter.currenttags,
        buttons         = require("core.widgets.tasklist_buttons"),
        style           = { shape = gears.shape.rounded_bar },
        layout          = { spacing = 2, layout = wibox.layout.fixed.horizontal },
        widget_template = {
            {
                {
                    {
                        { id = "text_role", widget = wibox.widget.textbox },
                        layout = wibox.layout.fixed.horizontal
                    },
                    -- Each tasklist button
                    left = 5,
                    right = 5,
                    bottom = 3,
                    widget = wibox.container.margin
                },
                id = 'background_role',
                shape = gears.shape.rounded_bar,
                widget = wibox.container.background
            },
            -- Entire tasklist
            left = 5,
            widget = wibox.container.margin
        }
    })

    return screen.mytasklist
end

return make_tasklist

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
