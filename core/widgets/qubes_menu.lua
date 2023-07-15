local menu = require("lib.menu")
local qubes = require("lib.qubes")

-- Qubes Menu
return menu { items = qubes.make_menu() }

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
