local awful = require("awful")
local wibox = require("wibox")

local function make_taglist(screen)
    screen.mytaglist = awful.widget.taglist {
        screen  = screen,
        filter  = awful.widget.taglist.filter.all,
        layout  = { layout = wibox.layout.fixed.horizontal },
        buttons = require("core.widgets.taglist_buttons")
    }

    return screen.mytaglist
end

return make_taglist

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
