local awful = require("awful")
-- If something breaks down the line (e.g. keybinds),
-- it's nice to have a terminal open for debugging.
--awful.spawn('alacritty')

-- Imports
local beautiful = require("beautiful")
local gears = require("gears")
local config = require("config")

-- Load the theme
beautiful.init(config.theme)

-- What you're here for.
-- The order matches the default rc.lua order.
require("core.error_handling")
require("core.layouts")
require("core.tags")
require("core.bar.bar")
require("core.bindings.bindings")
require("core.rules")
require("core.notif")
require("core.titlebars")
require("core.autostart")

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
