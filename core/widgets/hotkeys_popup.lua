local hotkeys_popup = require("lib.hotkeys_popup")
local theme = require("config").theme

return hotkeys_popup.widget.new( {
    hotkeys_group_font = theme.hotkeys_group_font,
    hotkeys_page_up_key = theme.hotkeys_page_up_key,
    hotkeys_page_down_key = theme.hotkeys_page_down_key,
} )

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
