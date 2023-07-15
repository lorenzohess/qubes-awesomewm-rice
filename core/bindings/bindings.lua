local awful = require("awful")
local gears = require("gears")

local qubes_menu = require("core.bar.widgets").qubes_menu
local mytags = require("core.tags")
local sharedtags = require("lib.sharedtags")

local config = require("config")
local bindings = require("core.bindings.binding_functions")
local hotkeys_widget = require("core.widgets.hotkeys_popup")

local apps = config.apps
local localBin = config.dirs.localBin
local dmenuBin = config.dirs.dmenuBin

-- Modkeys
local mod = 'Mod1'
local shift = "Shift"
local ret = "Return"
local ctrl = "Control"

-- Mouse bindings
root.buttons(gears.table.join(
awful.button({}, 3, function() qubes_menu:toggle() end),
awful.button({}, 4, awful.tag.viewnext),
awful.button({}, 5, awful.tag.viewprev)
))

-- Layout
globalkeys = gears.table.join(
awful.key({ mod }, "space", function() awful.layout.inc(1) end,
{ description = "select next layout", group = "layout" }),

awful.key({ mod, shift }, "space", function() awful.layout.inc(-1) end,
{ description = "select previous layout", group = "layout" }),

awful.key({ mod }, 'l', function() awful.tag.incmwfact(0.03) end,
{ description = "increase master width factor", group = "layout" }),

awful.key({ mod }, 'h', function() awful.tag.incmwfact(-0.03) end,
{ description = "decrease master width factor", group = "layout" }),

awful.key({ mod, shift }, 'h', function() awful.tag.incnmaster(1, nil, true) end,
{ description = "increase the number of master clients", group = "layout" }),

awful.key({ mod, shift }, 'l', function() awful.tag.incnmaster(-1, nil, true) end,
{ description = "decrease the number of master clients", group = "layout" }),

-- Client
awful.key({ mod }, 'j', function() awful.client.focus.byidx(1) end,
{ description = "focus next client by index", group = "client" } ),

awful.key({ mod }, 'k', function() awful.client.focus.byidx(-1) end,
{ description = "focus previous client by index", group = "client" } ),

awful.key({ mod, shift }, 'j', function() awful.client.swap.byidx(1) end,
{ description = "swap with next client by index", group = "client" }),

awful.key({ mod, shift }, 'k', function() awful.client.swap.byidx(-1) end,
{ description = "swap with previous client by index", group = "client" }),

-- Screen
awful.key({ mod }, 'e', function() awful.screen.focus_relative(-1) end,
{ description = "focus the next screen", group = "screen" }),

awful.key({ mod }, 'w', function() awful.screen.focus_relative(1) end,
{ description = "focus the previous screen", group = "screen" }),

-- Terminals
awful.key({ mod }, ret, function() awful.spawn.with_shell(localBin .. "/qubes-i3-sensible-terminal") end,
{ description = "open terminal in focused client VM", group = "terminals" }),

awful.key({ mod, shift }, ret, function() awful.spawn(apps.dom0Terminal) end,
{ description = "open terminal in dom0", group = "terminals" }),

awful.key({ mod, ctrl }, ret, function() awful.spawn.with_shell(dmenuBin .. "/dm-open-terminal-in-vm.sh") end,
{ description = "open terminal in VM chosen in dmenu", group = "terminals" }),

-- Tags
awful.key({ mod }, 'Tab', awful.tag.history.restore,
{ description = "focus previous tag", group = 'tag' }),

-- Media
awful.key({}, "XF86AudioRaiseVolume", function() awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%") end, { description = "raise volume", group = "multimedia" }),

awful.key({}, "XF86AudioLowerVolume", function() awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%") end, { description = "lower volume", group = "multimedia" }),

-- VM apps
awful.key({ mod }, 'g',
bindings.vmWork.emacsclient,
{ description = "work > emacsclient", group = "VM apps" }),

awful.key({ mod }, 'd',
bindings.dmenu.emacsDictionary,
{ description = "dom0 dmenu > work > emacsclient dictionary", group = "VM apps" }),

awful.key({ mod }, 's',
bindings.vmSchool.brave,
{ description = "school > brave browser", group = "VM apps" }),

awful.key({ mod }, 't',
bindings.vmThunderbird.thunderbird, 
{ description = "thunderbird > thunderbird", group = "VM apps" }),

awful.key({ mod }, 'm',
bindings.vmSignal.signal, 
{ description = "signal > signal desktop", group = "VM apps" }),

-- dom0 dmenu
awful.key({ mod }, 'r',
bindings.dmenu.desktopRun, 
{ description = "run dmenu", group = "dom0 dmenu" }),

awful.key({ mod, shift }, 'r',
bindings.dmenu.qubeManager,
{ description = "basic qube manager", group = 'dom0 dmenu' }),

awful.key({ mod }, 'x',
bindings.dmenu.settings,
{ description = "toggle certain settings", group = 'dom0 dmenu' }),

awful.key({ mod }, 'n',
bindings.dmenu.netVMSwitcher,
{ description = "switch NetVM of any VM", group = 'dom0 dmenu' }),

awful.key({ mod }, 'b',
bindings.dmenu.browserLauncher,
{ description = "launch DispVM browser", group = 'dom0 dmenu' }),

-- dom0 scripts
awful.key({ mod, shift }, 'x',
bindings.scripts.tripleMonitors,
{ description = "toggle triple monitor setup", group = "dom0 scripts" }),

awful.key({ mod, ctrl }, 'e',
bindings.scripts.lockScreen,
{ description = "lock screen with " .. config.screenlock.process_name, group = "dom0 scripts" }),

awful.key({ mod, ctrl}, '0',
bindings.scripts.shutdown,
{ description = "shutdown now", group = "dom0 scripts" }),

-- Awesome
awful.key({ mod, shift }, 'a', function() hotkeys_widget:show_help(nil, awful.screen.focused()) end,
{ description = "show hotkeys help popup", group = "awesome" }),

awful.key({ mod, ctrl }, 'r', awesome.restart,
{ description = "reload awesome", group = "awesome" }),

awful.key({ mod, ctrl }, 'q', awesome.quit,
{ description = "quit awesome", group = "awesome" })
)

-- Client (keys)
clientkeys = gears.table.join(
awful.key({ mod }, 'f', function(c) c.fullscreen = not c.fullscreen c:raise() end,
{ description = "toggle fullscreen", group = "client" }),

awful.key({ mod, shift }, 'c', function(c) c:kill() end,
{ description = "close", group = "client" }),

awful.key({ mod, shift }, 'e', function(c) c:move_to_screen(c.screen.index - 1) end,
{ description = "move to previous screen", group = "client" }),

awful.key({ mod, shift }, 'w', function(c) c:move_to_screen() end,
{ description = "move to next screen", group = "client" }),

awful.key({ mod, ctrl }, "space", awful.client.floating.toggle,
{ description = "toggle floating", group = "client" }),

awful.key({ mod }, 'c', function() awful.placement.centered() end,
{ description = "center to middle of screen", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ mod }, '#' .. i + 9,
    function()
        local screen = awful.screen.focused()
        --local tag = screen.tags[i] -- sharedtags diff
        local tag = mytags[i] -- sharedtags diff add
        if tag then
            --tag:view_only() -- sharedtags diff
            sharedtags.viewonly(tag, screen) -- sharedtags diff add
        end
    end,
    { description = "view tag #" .. i, group = 'tag' }),

    -- Move client to tag.
    awful.key({ mod, shift }, '#' .. i + 9,
    function()
        if client.focus then
            --local tag = client.focus.screen.tags[i] -- sharedtags diff
            local tag = mytags[i] -- sharedtags diff add
            if tag then
                --client.focus:move_to_tag(tag) -- sharedtags diff
                client.focus:move_to_tag(tag)
            end
        end
    end,
    { description = "move focused client to tag #" .. i, group = 'tag' })
    )
end

clientbuttons = gears.table.join(
awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
end),

awful.button({ mod }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
end),

awful.button({ mod }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
end)
)

-- Set keys
root.keys(globalkeys)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
