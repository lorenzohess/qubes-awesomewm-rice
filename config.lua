local gears = require("gears")
local beautiful = require("beautiful")

-- Apps
local apps = {
    dom0Terminal = "alacritty",
    -- dom0Editor = 'vim',
    -- dom0EditorCmd = "alacritty -e vim",
    -- vmTerminal = "alacritty",
    -- vmEditor = "emacsclient -c -a 'vim'",
}

-- Directories
homeDir = os.getenv('HOME')
localBin = homeDir .. "/.local/bin"
scriptsDir = homeDir .. "/scripts"
dmenuBin = scriptsDir .. "/dm-scripts"

configDir = gears.filesystem.get_configuration_dir() -- usually ~/.config/awesome/
localShareDir = gears.filesystem.get_xdg_data_home() -- usually ~/.local/share/
widgetsBin = configDir .. '/bin'
wallpaperDir = localShareDir .. "assets/wallpapers"

local dirs = {
    homeDir = homeDir,
    configDir = configDir,
    localBin = localBin,
    widgetsBin = widgetsBin,
    dmenuBin = dmenuBin,
    wallpaperDir = wallpaperDir,
    scriptsDir = scriptsDir
}

-- Choose theme
--local theme = require("themes.qubes_os")
local theme = require("themes.doom_one")

local function setWallpaper(s)
    beautiful.wallpaper = localShareDir .. "wallpapers/wallpaper"
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.tiled(wallpaper, s)
    end
end

-- Screenlocker
local screenlock = {}
screenlock.process_name = "xscreensaver"
screenlock.enable_action = screenlock.process_name .. " -no-splash"
screenlock.disable_action = "pkill " .. screenlock.process_name

local config = {
    dirs = dirs,
    apps = apps,
    set_wallpaper = setWallpaper,
    colorscheme = colorscheme,
    theme = theme,
    screenlock = screenlock
}

return config

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
