local awful = require("awful")

local helpers = {}

local function compute_menu_fonts(family, focus_weight, focus_size_increase)
    -- Num VMs | Font Size | Menu Item Height
    -- 64      | 10, 12    | 15
    -- 47      | 14, 16    | 22
    -- 33      | 16, 18    | 26

    local numVMs = 0
    local vm_count_cmd = "qvm-ls --raw-list | wc -l"

    -- This synchronous call is only performed at Awesome startup.
    local f = io.popen(vm_count_cmd, 'r')
    if f then
        numVMs = tonumber(f:read('*a'))
        f:close()
    end

    if numVMs <= 33 then
        size = 16
        height = 26
    elseif numVMs <= 47 then
        size = 14
        height = 22
    else
        size = 10
        height = 15
    end

    local focus_size = size + focus_size_increase

    local menu_font = string.format("%s %d", family, size)
    local menu_focus_font = string.format("%s %s %d", family, focus_weight, focus_size)

    return menu_font, menu_focus_font, height
end

helpers.compute_menu_fonts = compute_menu_fonts

return helpers

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
