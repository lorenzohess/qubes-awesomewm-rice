local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local theme = require("config").theme.calendar

-- Most of this file taken from AwesomeWM docs on calendar widget,
-- and the worker() function is taken from awesome-wm-widgets.
local calendar = {}

local function worker()
    local placement = theme.placement
    local start_sunday = theme.start_sunday
    local long_weekdays = theme.long_weekdays

    local styles = {}

    local function rounded_shape(size, partial)
        if partial then
            return function(cr, width, height)
                gears.shape.partially_rounded_rect(cr, width, height,
                false, true, false, true, 5)
            end
        else
            return function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, size)
            end
        end
    end

    styles.month = {
        padding = 4,
        bg_color = theme.bg, -- calendar background
    }

    styles.normal = {
        shape = rounded_shape(4)
    }

    styles.focus = {
        fg_color = theme.today_fg, -- today fg
        bg_color = theme.today_bg, -- today bg
        markup = function(t) return '<b>' .. t .. '</b>' end,
        shape = rounded_shape(4),
    }

    styles.header = {
        fg_color = theme.header_fg, -- header fg
        markup = function(t) return '<b>' .. t .. '</b>' end,
        shape = rounded_shape(4),
    }

    styles.weekday = {
        fg_color = theme.weekday_fg,
        bg_color = theme.weekday_bg,
        markup = function(t) return '<b>' .. t .. '</b>' end,
    }

    local function decorate_embed_fn(widget, flag, date)
        if flag == 'monthheader' and not styles.monthheader then
            flag = 'header'
        end
        local props = styles[flag] or {}
        if props.markup and widget.get_text and widget.set_markup then
            widget:set_markup(props.markup(widget:get_text()))
        end
        -- Change bg color for weekends
        local dates = { year = date.year, month = (date.month or 1), day = (date.day or 1) }
        local weekday = tonumber(os.date('%w', os.time(dates)))
        -- () and weekend bg or header, weekday bg
        local default_bg = (weekday == 0 or weekday == 6)
        and theme.weekend_bg
        or theme.bg
        local ret = wibox.widget {
            {
                { widget, halign = 'center', widget = wibox.container.place },
                margins = (props.padding or 2) + (props.border_width or 0),
                widget = wibox.container.margin
            },
            shape = props.shape,
            shape_border_color = props.border_color or theme.inside_borders,
            shape_border_width = props.border_width or 0,
            fg = props.fg_color or theme.fg,
            bg = props.bg_color or default_bg,
            widget = wibox.container.background
        }
        return ret
    end

    local calendar = wibox.widget {
        date = os.date('*t'),
        font = theme.font,
        fn_embed = decorate_embed_fn,
        long_weekdays = long_weekdays,
        start_sunday = start_sunday,
        widget = wibox.widget.calendar.month
    }

    local popup = awful.popup {
        ontop = true,
        visible = false,
        shape = rounded_shape(5),
        offset = { y = 5 },
        border_color = theme.border,
        border_width = 1,
        widget = calendar,
    }

    function calendar.toggle()
        if popup.visible then
            calendar:set_date(nil)
            calendar:set_date(os.date('*t'))
            popup:set_widget(nil)
            popup:set_widget(calendar)
            popup.visible = not popup.visible
        else
            if placement == 'top' then
                awful.placement.top(popup, { margins = { top = 30 }, parent = awful.screen.focused() })
            elseif placement == 'top_right' then
                awful.placement.top_right(popup, { margins = { top = 30, right = 10 }, parent = awful.screen.focused() })
            elseif placement == 'top_left' then
                awful.placement.top_left(popup, { margins = { top = 30, left = 10 }, parent = awful.screen.focused() })
            elseif placement == 'bottom_right' then
                awful.placement.bottom_right(popup, { margins = { top = 30, right = 10 }, parent = awful.screen.focused() })
            elseif placement == 'bottom_left' then
                awful.placement.bottom_left(popup, { margins = { top = 30, left = 10 }, parent = awful.screen.focused() })
            else
                awful.placement.top(popup, { margins = { top = 30 }, parent = awful.screen.focused() })
            end

            popup.visible = true
        end
    end
    return calendar
end

return setmetatable(calendar, { __call = function(_, ...)
    return worker(...)
end })

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
