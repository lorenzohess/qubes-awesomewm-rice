local awful = require("awful")
local beautiful = require("beautiful")

-- Make sure a client is focused when switching tags
require("awful.autofocus")

local mytags = require("core.tags")

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                'DTA', -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin", -- kalarm.
                "Qubes-update-gui",
                "Qubes Restore VMs",
                'Sxiv',
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
                "Zenity"
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester", -- xev.
                "Download an external file type?",
                "Downloads - File Manager",
                "user - File Manager",
                'sh',
                "Qubes OS - Backup Qubes",
                "Nitrokey App",
                "Welcome to Brave",
                "Story Editor - Class Year",
                "Image Recovery",
                "Quit GIMP",
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
            }
        }, properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = true }
    },

    -- Open windows on specific tags
    --   use `screen = function() return screen.count() end,` to place a window on screen 2
    --   when external monitor is connected and on screen one when it's not
    -- Use `$ xprop WM_CLASS` to get the class, which is the string after the colon
    --   in the second string (after the comma).
    {
        rule = { class = "Thunderbird" },
        properties = { tag = mytags['6'] }
    },
    {
        rule = { class = "Tor Browser" },
        properties = { tag = mytags['4'] }
    },
    {
        rule = { class = "Signal" },
        properties = { tag = mytags['7'] }
    },
    {
        rule = { class = "Qubes-update-gui" },
        properties = { tag = mytags['9'] }
    },
    {
        rule = { class = "qubes-qube-manager" },
        properties = { tag = mytags['9'] }
    },
    {
        rule = { class = "Qubes Restore VMs" },
        properties = { tag = mytags['9'] }
    },

    -- Close sys-net wifi icon if it opens as a window (e.g. on Awesome restart).
    {
        rule = { class = "Nm-applet" },
        properties = {}, 
        callback = function(c) c:kill() end
    },
    {
        rule = { name = "NetworkManager Applet" },
        properties = {}, 
        callback = function(c) c:kill() end
    },
}

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
