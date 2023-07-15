local awful = require("awful")
local wibox = require("wibox")

local config = require("config")
local mytags = require("core.tags")
local sharedtags = require("lib.sharedtags")
local widgets = require("core.bar.widgets")

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    config.set_wallpaper(s)

    -- Assign tags to the newly connected screen here, if desired:
    sharedtags.viewonly(mytags[1]) -- startup tag

    -- Create layoutbox and assign to screen.
    local make_layoutbox = require("core.widgets.make_layoutbox")
    local layoutbox_widget = make_layoutbox(s)

    -- Create tasklist and assign to screen.
    local make_tasklist = require("core.widgets.make_tasklist")
    local tasklist_widget = make_tasklist(s)

    -- Create taglist and assign to screen.
    local make_taglist = require("core.widgets.make_taglist")
    local taglist_widget = make_taglist(s)

    -- Create the wibox
    s.mywibox = awful.wibar { position = 'top', screen = s, input_passthrough = true }

    -- Add widgets to the wibox
    s.mywibox:setup {
        {
            -- Left widgets
            {
                layout = wibox.layout.fixed.horizontal,
                widgets.launcher,
                taglist_widget,
            },
            -- Middle widgets
            {
                layout = wibox.layout.fixed.horizontal,
                tasklist_widget,
            },
            -- Right widgets
            {
                layout = wibox.layout.fixed.horizontal,
                widgets.systray,
                widgets.space,
                widgets.keyboard,
                widgets.space,
                widgets.brightness,
                widgets.space,
                widgets.battery,
                widgets.space,
                widgets.kernel,
                widgets.space,
                widgets.clipboard,
                widgets.space,
                widgets.qubecount,
                widgets.space,
                widgets.datetime,
                widgets.space,
                widgets.system,
                widgets.space,
                layoutbox_widget
            },
            layout = wibox.layout.align.horizontal
        },
        top = 0,
        widget = wibox.container.margin
    }
end)

-- Redraw wallpaper after screen geometry changes.
screen.connect_signal("property::geometry", config.set_wallpaper)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
