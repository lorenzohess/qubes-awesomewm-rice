---------------------
-- Doom One Theme  --
---------------------

local gears = require("gears")

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local helpers = require("lib.theme_helpers")

-- Load the Doom One color palette
local colors = require("themes.doom_one_colors")

-- Hexademical alpha channel notes:
--   #xxxxxx00 is 0% opacity (invisible)
--   #xxxxxxff is 100% opacity (no change)
--          43 -> 25%
--          55 -> 33%
--          80 -> 50%
--          aa -> 67%
--          c0 -> 75%
--
-- Conversion:
--   2A  ->  2*16^1 + A*16^0 = 32 + 10 = 42
--   A1  ->  A*16^1 + 1*16^0 = 160 + 1 = 161
--   911 <-  3*16^2 + 8*16^1 + 15*16^0 = 38F

local alpha = { invisible = '00', quarter = '43', third = '55', half = '80', two_thirds = 'aa', three_fourths = 'c0' }

local theme = {}

local mononoki = "Mononoki Nerd Font Propo "
local ubuntumono = "Ubuntu Mono Nerd Font Propo "
local ostrichsans = "Ostrich Sans "
local opensans = "Open Sans "
local configDir = gears.filesystem.get_configuration_dir()

-- Font
theme.font          = mononoki

theme.bg_normal     = colors.dark_gray 
theme.fg_normal     = colors.soft_white
theme.bg_focus      = colors.light_gray
theme.fg_focus      = colors.white
theme.bg_urgent     = colors.danger_red
theme.fg_urgent     = colors.white
theme.bg_minimize   = colors.black
theme.fg_minimize   = colors.soft_white

theme.bg_systray    = theme.bg_normal

theme.useless_gap   = dpi(1)
theme.border_width  = dpi(1)

-- Wibar
theme.wibar_height  = 20
theme.wibar_bg      = theme.bg_normal
theme.wibar_fg      = theme.fg_normal
theme.wibar_border_width = 3
theme.wibar_border_color = theme.wibar_bg

-- Widgets
local widgets = {}

widgets.bg = colors.light_gray
widgets.fg = colors.soft_white -- standard text color, usually overridden

widgets.battery_fg = colors.blue
widgets.brightness_fg = colors.soft_yellow
widgets.clipboard_fg = colors.light_red
widgets.datetime_fg = colors.white
widgets.kernel_fg = colors.success_green
widgets.qubecount_fg = colors.qubes_blue
widgets.system_fg = colors.white

theme.widgets = widgets

-- Caps lock
widgets.capslock_off = widgets.fg
widgets.capslock_on = colors.alert_yellow

-- Tasklist
theme.tasklist_font = opensans .. '10'

-- Taglist
local taglist_shape_radius = 6
theme.taglist_shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, taglist_shape_radius) end
theme.taglist_shape_border_width = 0
theme.taglist_spacing = 2
theme.taglist_font = mononoki .. '14'

local taglist_bg_base = colors.qubes_blue
theme.taglist_bg_focus = taglist_bg_base .. alpha.three_fourths
theme.taglist_bg_occupied = taglist_bg_base .. alpha.third
theme.taglist_bg_empty = taglist_bg_base .. alpha.invisible
theme.taglist_fg_focus = colors.black

-- Calendar
-- Today is a current day.
-- Weekdays are the day of week _names_ (Mon, Tue, ...)
local calendar_bg = colors.black
local calendar = {
    placement = "top_right",
    start_sunday = true,
    long_weekdays = true,
    bg = calendar_bg,
    fg = colors.soft_white,
    today_bg = colors.soft_yellow,
    today_fg = colors.black,
    -- Weekend date boxes background, including
    -- weekend day of week background.
    weekend_bg = colors.dark_gray,
    -- Weekday day of week background, which overrides
    -- weekend day of week background (weekend_bg).
    weekday_bg = calendar_bg,
    weekday_fg = colors.blue,
    header_fg = colors.white,
    -- Calendar borders.
    border = colors.soft_white,
    -- Inside borders for header and date boxes.
    inside_borders = calendar_bg,
    font = theme.font .. '14',
}

theme.calendar = calendar

-- System widget
theme.sys_popup_fg = colors.soft_white
theme.sys_popup_bg = colors.dark_gray
theme.sys_popup_border_color = colors.light_gray
theme.sys_popup_border_width = 3
theme.sys_popup_font = mononoki .. "Bold 20"

-- Hotkeys popup
theme.hotkeys_font = opensans .. "Bold 14"
theme.hotkeys_description_font = theme.font .. '14'
theme.hotkeys_group_font = opensans .. "Bold 16"
theme.hotkeys_fg = colors.soft_white
theme.hotkeys_modifiers_fg = colors.soft_yellow
theme.hotkeys_bg = colors.black
theme.hotkeys_shape = gears.shape.rounded_rect
theme.hotkeys_page_up_key = 'k' -- "Prior" for Page Up
theme.hotkeys_page_down_key = 'j' -- 'Next' for Page Down

theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_width  = dpi(200)
local menu_font_family = mononoki
local menu_focus_weight, menu_focus_size_increase = 'Bold', 2

theme.menu_font, theme.menu_focus_font, height = helpers.compute_menu_fonts(menu_font_family, menu_focus_weight, menu_focus_size_increase)
theme.menu_height = dpi(height)

-- Define the images to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

-- Set layout icons
--theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
--theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
--theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
--theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
--theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
--theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
--theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
--theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
--theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
--theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
--theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
--theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
theme.menu_height, theme.bg_focus, theme.fg_focus
)

theme.qubes_logo_icon = configDir .. "assets/qubes-logo-icon.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
