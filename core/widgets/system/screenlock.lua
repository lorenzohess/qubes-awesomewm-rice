local awful = require("awful")

local config = require("config")
local text_with_icon = require("core.widgets.system.helpers").text_with_icon

local screenlock = {}

local status_button = text_with_icon('', '')

local function screenlock_worker(when_running, when_not_running)
    awful.spawn.easy_async_with_shell("pgrep " .. config.screenlock.process_name,
    function(stdout, stderr, reason, exit_code)
        if exit_code == 0 then
            when_running()
        else
            when_not_running()
        end
    end)
end

local function screenlock_status_enable()
    status_button.first.text = " 󱞩 enabled"
    status_button.third.widget.text = '󰍁'
end

local function screenlock_status_disable()
    status_button.first.text = " 󱞩 disabled"
    status_button.third.widget.text = '󰿇'
end

-- If the screenlock program is running, disable it and change the textbox to
-- disabled. If not running, enable it and change textbox to enabled.
local function toggle_screenlock()
    local when_running = function()
        screenlock_status_disable()
        awful.spawn.with_shell(config.screenlock.disable_action)
    end

    local when_not_running = function()
        screenlock_status_enable()
        awful.spawn.with_shell(config.screenlock.enable_action)
    end

    screenlock_worker(when_running, when_not_running)
end

local function update_icon()
    local when_running = function()
        screenlock_status_enable()
    end

    local when_not_running = function()
        screenlock_status_disable()
    end

    screenlock_worker(when_running, when_not_running)
end

local lock_button = text_with_icon('<i>Screenlock</i>', '󰷛')
local lock_screen = function() awful.spawn("xscreensaver-command -lock") end

lock_button:connect_signal("button::press", function() lock_screen() end)

status_button:connect_signal("button::press", function()
    toggle_screenlock() 
end)

screenlock.lock_button = lock_button
screenlock.status_button = status_button
screenlock.update_icon = update_icon

return screenlock

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
