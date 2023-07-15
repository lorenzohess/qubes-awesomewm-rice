local awful = require("awful")
local theme = require("config").theme

-- Menu Launcher
local qubes_menu = require("core.widgets.qubes_menu")

return awful.widget.launcher {
    image = theme.qubes_logo_icon,
    menu = qubes_menu
}

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
