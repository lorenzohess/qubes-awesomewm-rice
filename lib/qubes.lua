----------------------------------------------------------------------------
-- Qubes OS bridge
-- @copyright 2014 Invisible Things Lab
-- @copyright 2014 Wojciech Porczyk <woju@invisiblethingslab.com>
-- license: GPL-2+
----------------------------------------------------------------------------

local io = io
local math = math
local string = string
local tonumber = tonumber
local table = table

local client = require('awful.client')
local util = require('awful.util')
local color = require('gears.color')
local gstring = require('gears.string')
local beautiful = require('beautiful')
local menubar = require('menubar')

local qubes = {}

local HOME = os.getenv('HOME')

-- the following three functions are lifted from
--  /usr/lib64/python2.7/colorsys.py

-- XXX this belongs to /usr/share/awesome/lib/gears/colors.lua

local function rgb_to_hls(r, g, b)
    maxc = math.max(r, g, b)
    minc = math.min(r, g, b)
    -- XXX Can optimize (maxc+minc) and (maxc-minc)
    l = (minc+maxc)/2.0
    if minc == maxc then
        return 0.0, l, 0.0
    end
    if l <= 0.5 then
        s = (maxc-minc) / (maxc+minc)
    else
        s = (maxc-minc) / (2.0-maxc-minc)
    end
    rc = (maxc-r) / (maxc-minc)
    gc = (maxc-g) / (maxc-minc)
    bc = (maxc-b) / (maxc-minc)
    if r == maxc then
        h = bc-gc
    elseif g == maxc then
        h = 2.0+rc-bc
    else
        h = 4.0+gc-rc
    end
    h = (h/6.0) % 1.0
    return h, l, s
end

local function v(m1, m2, hue)
    hue = hue % 1.0
    if hue < 1/6 then
        return m1 + (m2-m1)*hue*6.0
    end
    if hue < 0.5 then
        return m2
    end
    if hue < 2/3 then
        return m1 + (m2-m1)*(2/3-hue)*6.0
    end
    return m1
end

local function hls_to_rgb(h, l, s)
    if s == 0.0 then
        return l, l, l
    end
    if l <= 0.5 then
        m2 = l * (1.0+s)
    else
        m2 = l+s-(l*s)
    end
    m1 = 2.0*l - m2
    return v(m1, m2, h+1/3), v(m1, m2, h), v(m1, m2, h-1/3)
end

-- end of codelifting

local function ensure_min_luminance(colour, minLuminance)
    local r, g, b = color.parse_color(colour)

    h, l, s = rgb_to_hls(r, g, b)
    l = math.max(l,minLuminance)
    r, g, b = hls_to_rgb(h, l, s)

    return string.format('#%02x%02x%02x', math.floor(r * 0xff), math.floor(g * 0xff), math.floor(b * 0xff))
end

local function shift_luminance(colour, factor)
    local r, g, b = color.parse_color(colour)

    h, l, s = rgb_to_hls(r, g, b)
    l = math.max(math.min(l * factor, 1), 0)
    r, g, b = hls_to_rgb(h, l, s)

    return string.format('#%02x%02x%02x', math.floor(r * 0xff), math.floor(g * 0xff), math.floor(b * 0xff))
end

local function color_dec2hex(dec_color,default)
    if dec_color == nil or dec_color == '' then 
        return default
    else
        -- Convert decimal color into hexademical with the '%x' formatting
        return string.format("#%06x", dec_color)
    end
end

local function pread(cmd)
    local f, err = io.popen(cmd, 'r')
    if f then
        local data = f:read('*all')
        f:close()
        return data
    else
        error("Command failed:\n" .. cmd .. "\nwith error:\n" .. err )
    end
end

function qubes.manage(c)
    local data = pread('xprop -id ' .. c.window .. ' -notype _QUBES_VMNAME _QUBES_LABEL _QUBES_LABEL_COLOR')

    --set some window properties for information
    c.qubes_vmname = string.match(data, '_QUBES_VMNAME = "(.+)"') or 'dom0'
    c.qubes_label = string.match(data, '_QUBES_LABEL = (%d+)') or '*'
    -- Get the decimal window color
    local qcolor = color_dec2hex(string.match(data, '_QUBES_LABEL_COLOR = (%d+)'), '#000000')
    c.qubes_label_color = qcolor
    c.qubes_prefix = '[' .. c.qubes_vmname .. '] '

    --set the focus & unfocus colors for later usage
    local qcolor_focus = ensure_min_luminance(qcolor, 0.3)
    c.qubes_label_color_focus = qcolor_focus
    c.qubes_label_color_unfocus = shift_luminance(qcolor_focus, 0.6)

    --set the initial border color
    qubes.set_border_colour(c)
end

function qubes.set_border_colour(c)
    --assume focus by default - it might not be set due to a racing condition in client.manage()
    if (client.focus.window == nil) or (c == client.focus) then
        c.border_color = qubes.get_colour_focus(c)
    else
        c.border_color = qubes.get_colour(c)
    end
end

function qubes.get_colour(c)
    if c.qubes_label_color_unfocus == nil then
        qubes.manage(c)
    end
    return c.qubes_label_color_unfocus
end

function qubes.get_colour_focus(c)
    if c.qubes_label_color_focus == nil then
        qubes.manage(c)
    end
    return c.qubes_label_color_focus
end

function qubes.set_name(c)
    if c.qubes_prefix == nil then
        qubes.manage(c)
    end
    name = c.name or ''
    if not gstring.startswith(name, c.qubes_prefix) then
        c.name = c.qubes_prefix .. name
    end
end

local function is_accessible(path)
    return os.rename(path, path) and true or false
end

function qubes.make_menuitem(vm, program)
    local appicon = program.icon_path
    if not is_accessible(appicon) then appicon = nil end

    return {program.Name, program.cmdline, appicon}
end

--menuitemfunc & vmicon are optional parameters
function qubes.make_vm_menu(vmname, desktop_files, menuitemfunc, vmicon)
    local menu = {}
    local menuitemfunc = menuitemfunc or qubes.make_menuitem

    if vmname == nil then return nil end

    local vmicon = vmicon
    if vmicon == nil then
        vmicon_name = pread('qvm-prefs -- ' .. vmname .. ' icon'):sub(1, -2)
        vmicon = '/usr/share/icons/hicolor/128x128/devices/' .. vmicon_name .. '.png'
    end

    for _, dfile in pairs(desktop_files) do
        if dfile ~= nil then
            local dpath = HOME .. '/.local/share/applications/' .. dfile
            if is_accessible(dpath) then
                local menuitem = menuitemfunc(vmname, menubar.utils.parse_desktop_file(dpath))
                if menuitem ~= nil then table.insert(menu, menuitem) end
            end
        end
    end

    if next(menu) == nil then
        return nil
    else
        --NOTE: awesome will not display menu entries with invalid icon paths
        return {vmname, menu, vmicon}
    end
end

--filter, menuitemfunc & menuicon are optional parameters
--menu is an output parameter passed by reference
local function parse_menufile_dir(menu, menufile_dir, filter, menuitemfunc, menuicon)
    local menufunc = qubes.make_vm_menu
    local menuitemfunc = menuitemfunc or qubes.make_menuitem

    --since awesome only supports .desktop files, but Qubes also uses .menu files, we "parse" the .menu files with sed to find the relevant .desktop files for a VM
    local last_desktop_files = {}
    local last_name = nil
    local cmd = [[bash -c 'for file in ]] .. menufile_dir .. [[/*.menu; do sort -b "$file"; done']]
    --the sorting is needed to support arbitrary ordering of the xml tags
    for line in io.popen(cmd):lines() do
        local nmatch = string.match(line, '<Name>(.*)</Name>')
        if nmatch ~= nil and nmatch ~= "Applications" then
            --name of the 1st level menu:
            -- We need to check for 'dispvm' first since the second match also
            -- captures dispvm entries (user-qubes-dispvm-directory-*.menu)
            dvm_name = string.match(nmatch,'^qubes%-dispvm%-directory%-(.*)$')
            if dvm_name == nil then
                last_name = string.match(nmatch,'^qubes%-vm%-directory%-(.*)$')
                if last_name ~= nil then
                    table.insert(menu, menufunc(last_name, last_desktop_files, menuitemfunc, menuicon))
                end
            else
                table.insert(menu, menufunc(dvm_name, last_desktop_files, menuitemfunc, menuicon))
            end
            if filter ~= nil then menufunc = filter(last_name) end
            last_desktop_files = {}
        else
            --potential desktop file:
            local fmatch = string.match(line, '<Filename>(.*%.desktop)</Filename>')
            if fmatch ~= nil then table.insert(last_desktop_files, fmatch) end
        end
    end
end

--filter & menuitemfunc are optional parameters
function qubes.make_menu(filter, menuitemfunc)
    local menu = {}

    --add the awesome-specific menus
    --this is enitrely optional and enables users to create xdg menu files at the below file path in order to populate the first menu entries (e.g. for awesome-specific control tools)
    --the desktop files referenced from the .menu files must be stored at ~/.local/share/applications/
    --it will remain invisible until that directory has .menu files referencing valid .desktop files
    --parse_menufile_dir(menu, '~/.config/awesome/xdg-menu', filter, menuitemfunc, '/usr/share/icons/hicolor/16x16/apps/qubes-logo-icon.png')

    --add the VM application menus
    parse_menufile_dir(menu, '~/.config/menus/applications-merged', filter, menuitemfunc)

    return menu
end

return qubes

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
