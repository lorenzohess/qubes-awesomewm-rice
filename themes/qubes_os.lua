---------------------
-- Qubes OS Theme  --
---------------------

local gears = require("gears")

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local helpers = require("lib.theme_helpers")

-- Load the Doom One color palette
local colors = require("themes.qubes_os_colors")

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

local mononoki = "Mononoki Nerd Font Propo"
local ubuntumono = "Ubuntu Mono Nerd Font Propo"
local ostrichsans = "Ostrich Sans "
local opensans = "Open Sans "
local configDir = gears.filesystem.get_configuration_dir()

-- Font
theme.font      = ubuntumono

theme.bg_normal     = colors.soft_white 
theme.fg_normal     = colors.dark_gray
theme.bg_focus      = colors.light_gray
theme.fg_focus      = colors.black
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

widgets.bg = colors.white
widgets.fg = colors.black -- standard text color, usually overridden

widgets.battery_fg = colors.dark_blue
widgets.brightness_fg = colors.light_gray
widgets.clipboard_fg = colors.light_red
widgets.datetime_fg = colors.black
widgets.kernel_fg = colors.success_green
widgets.qubecount_fg = colors.qubes_blue
widgets.system_fg = colors.black

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
theme.taglist_font = ubuntumono .. '14'

local taglist_bg_base = colors.dark_blue
theme.taglist_bg_focus = taglist_bg_base .. alpha.three_fourths
theme.taglist_bg_occupied = taglist_bg_base .. alpha.half
theme.taglist_bg_empty = taglist_bg_base .. alpha.invisible
theme.taglist_fg_focus = colors.black

-- Calendar
-- Today is a current day.
-- Weekdays are the day of week _names_ (Mon, Tue, ...)
local calendar_bg = colors.soft_white
local calendar = {
    placement = "top_right",
    start_sunday = true,
    long_weekdays = true,
    bg = calendar_bg,
    fg = colors.black,
    today_bg = colors.green,
    today_fg = colors.white,
    -- Weekend date boxes background, including
    -- weekend day of week background.
    weekend_bg = colors.light_gray,
    -- Weekday day of week background, which overrides
    -- weekend day of week background (weekend_bg).
    weekday_bg = calendar_bg,
    weekday_fg = colors.dark_blue,
    header_fg = colors.black,
    -- Calendar borders.
    border = colors.black,
    -- Inside borders for header and date boxes.
    inside_borders = calendar_bg,
    font = opensans .. '12',
}

theme.calendar = calendar

-- System widget
theme.sys_popup_fg = colors.dark_gray
theme.sys_popup_bg = colors.soft_white
theme.sys_popup_border_color = colors.light_gray
theme.sys_popup_border_width = 3
theme.sys_popup_font = ubuntumono .. "Bold 20"

-- Hotkeys popup
theme.hotkeys_font = opensans .. "Bold 14"
theme.hotkeys_description_font = theme.font .. '14'
theme.hotkeys_group_font = opensans .. "Bold 16"
theme.hotkeys_fg = colors.black
theme.hotkeys_modifiers_fg = colors.dark_blue
theme.hotkeys_bg = colors.soft_white
theme.hotkeys_shape = gears.shape.rounded_rect
theme.hotkeys_page_up_key = 'Prior' -- "Prior" for Page Up
theme.hotkeys_page_down_key = 'Next' -- 'Next' for Page Down

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
theme.layout_fairv = themes_path.."default/layouts/fairv.png"
theme.layout_floating  = themes_path.."default/layouts/floating.png"
--theme.layout_magnifier = themes_path.."default/layouts/magnifier.png"
--theme.layout_max = themes_path.."default/layouts/max.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreen.png"
--theme.layout_tilebottom = themes_path.."default/layouts/tilebottom.png"
--theme.layout_tileleft   = themes_path.."default/layouts/tileleft.png"
theme.layout_tile = themes_path.."default/layouts/tile.png"
--theme.layout_tiletop = themes_path.."default/layouts/tiletop.png"
--theme.layout_spiral  = themes_path.."default/layouts/spiral.png"
--theme.layout_dwindle = themes_path.."default/layouts/dwindle.png"
--theme.layout_cornernw = themes_path.."default/layouts/cornernw.png"
--theme.layout_cornerne = themes_path.."default/layouts/cornerne.png"
--theme.layout_cornersw = themes_path.."default/layouts/cornersw.png"
--theme.layout_cornerse = themes_path.."default/layouts/cornerse.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
theme.menu_height, theme.bg_focus, theme.fg_focus
)

theme.qubes_logo_icon = configDir .. "assets/qubes-logo-icon-dark.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
