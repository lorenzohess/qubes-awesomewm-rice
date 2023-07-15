local awful = require("awful")

local config = require("config")

local dmenuBin = config.dirs.dmenuBin
local localBin = config.dirs.localBin
local scriptsDir = config.dirs.scriptsDir

-- Helper functions to run a script or command
local function qvm_run(vm, command)
    awful.spawn.with_shell([[qvm-run ]] .. vm .. [[ ']] .. command .. [[']])
end

local function dmenu_run(dir, script)
    awful.spawn.with_shell(dir .. '/' .. script)
end

local function script_run(script)
    awful.spawn.with_shell(scriptsDir .. '/' .. script)
end

-- Functions to run actual keybind command
-- Work
local function emacsclient() qvm_run('work', "emacsclient -cn -a vim") end

-- School
local function brave() qvm_run("school", "brave-browser") end

-- Thunderbird
local function thunderbird() qvm_run("thunderbird", "thunderbird") end

-- Signal
local function signal() qvm_run("signal", "/opt/Signal/signal-desktop") end

-- Dmenu
local function desktopRun() dmenu_run(localBin, "qubes-j4-dmenu-desktop") end
local function qubeManager() dmenu_run(dmenuBin, "dm-qube-manager.sh") end
local function settings() dmenu_run(dmenuBin, "dm-settings.sh") end
local function netVMSwitcher() dmenu_run(dmenuBin, "dm-netvm-switcher.sh") end
local function browserLauncher() dmenu_run(dmenuBin, "dm-browsers.sh") end
local function emacsDictionary() dmenu_run(dmenuBin, "dict.sh") end

-- Scripts
local function tripleMonitors() script_run("triple-monitors.sh") end
local function lockScreen() awful.spawn.with_shell("xscreensaver-command -lock") end
local function shutdown() awful.spawn.with_shell("sudo shutdown now") end

-- Keybind function tables
local binding_functions = {}

binding_functions.vmWork = {
    emacsclient = emacsclient
}

binding_functions.vmSchool = {
    brave = brave
}

binding_functions.vmThunderbird = {
    thunderbird = thunderbird
}

binding_functions.vmSignal = {
    signal = signal
}

binding_functions.dmenu = {
    desktopRun = desktopRun,
    qubeManager = qubeManager,
    settings = settings,
    netVMSwitcher = netVMSwitcher,
    browserLauncher = browserLauncher,
    emacsDictionary = emacsDictionary
}

binding_functions.scripts = {
    tripleMonitors = tripleMonitors,
    lockScreen = lockScreen,
    shutdown = shutdown
}

return binding_functions

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
