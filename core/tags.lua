local sharedtags = require("lib.sharedtags")
local awful = require("awful")

local tags = sharedtags({
  { name = '1', screen = 2, layout = awful.layout.layouts[1] },
  { name = '2', screen = 2, layout = awful.layout.layouts[1] },
  { name = '3', screen = 2, layout = awful.layout.layouts[1] },
  { name = '4', screen = 2, layout = awful.layout.layouts[1] },
  { name = '5', screen = 2, layout = awful.layout.layouts[1] },
  { name = '6', screen = 2, layout = awful.layout.layouts[1] },
  { name = '7', screen = 1, layout = awful.layout.layouts[1] },
  { name = '8', screen = 1, layout = awful.layout.layouts[1] },
  { name = '9', screen = 1, layout = awful.layout.layouts[1] }
})

return tags

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
