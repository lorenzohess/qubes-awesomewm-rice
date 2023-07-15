local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local qubes = require("lib.qubes")
local invertHex = require("lib.invertHex")

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    qubes.manage(c)
    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
    c.shape = gears.shape.rounded_rect -- rounded borders on clients
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
    awful.button({}, 1, function()
        c:emit_signal("request::activate", "titlebar", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", { raise = true })
        awful.mouse.client.resize(c)
    end)
    )

    qubes.manage(c)
    awful.titlebar(c,
    { size = 15, bg_normal = qubes.get_colour(c), bg_focus = qubes.get_colour_focus(c),
    fg_normal = invertHex.invert(qubes.get_colour(c), true),
    fg_focus = invertHex.invert(qubes.get_colour_focus(c), true)
}):setup
{
    -- Left
    {
        awful.titlebar.widget.iconwidget(c),
        buttons = buttons,
        layout  = wibox.layout.fixed.horizontal
    },
    -- Middle
    {
        -- Title
        { align = "center", widget = awful.titlebar.widget.titlewidget(c) },
        buttons = buttons,
        layout  = wibox.layout.flex.horizontal
    },
    -- Right
    {
        awful.titlebar.widget.floatingbutton(c),
        awful.titlebar.widget.maximizedbutton(c),
        --awful.titlebar.widget.stickybutton   (c),
        --awful.titlebar.widget.ontopbutton    (c),
        awful.titlebar.widget.closebutton(c),
        layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
}
end)

-- Put the Qube name in front of all displayed names (tilebars, tasklists, ...)
client.connect_signal("property::name", function(c) qubes.set_name(c) end)

client.connect_signal("focus", function(c) c.border_color = qubes.get_colour_focus(c) end)
client.connect_signal("unfocus", function(c) c.border_color = qubes.get_colour(c) end)

-- Consider the danger of focus stealing
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
