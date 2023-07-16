My AwesomeWM configuration for Qubes OS.

Changes and additions to the standard Qubes OS AwesomeWM install:

1.  Split `rc.lua` into 11 separate files for ease of use and more accessible auditing.
2.  Make tasklist client buttons reflect clients&rsquo; Qubes titlebar colors
3.  Programatically increase contrast between titlebar font and titlebar color
4.  Improve and add widgets, some specific to Qubes OS.
5.  Add the tiny `sharedtags` library to share tags over multiple screens.

There are no complex, bloated widgets and every modified Awesome widget is kept nearly identical to its original.

For a detailed overview of the project, see <doc.md>.


# Install

1.  Install `awesome`: see [qubes-os.org/doc/awesome](https://qubes-os.org/doc/awesome).
2.  Clone this repo and make a tarball of everything you want to copy to *dom0*. To use this with no modifications, the minimum you need to transfer to *dom0* is:
    -   `assets/`
        -   `qubes-logo-icon-dark.png`
        -   `qubes-logo-icon.png`
    -   everything under `bin/`, `core/`, `lib/`, `themes/`
    -   `config.lua`
    -   `rc.lua`
3.  Extract the tarball to `~/.config/awesome`.
4.  Log out and log in again, making sure to select Awesome in the login manager.


## Dependencies

1.  Mononoki Nerd Font, Ubuntu Mono Nerd Font, and Open Sans. If you don&rsquo;t want to use these fonts, change the fonts in the theme files to ones you want to use. You need a Nerd Font to get the widget icons.
2.  The `xset` program, which should be already installed.


## Notes

1.  The commands to run when Awesome starts (in `bin/autorun.sh`) will only run if your username is `lhess` to prevent them accidentally running on another system.
2.  Review `bin/brightness.sh` to confirm you have access to those brightness files under `/sys`.


# Roadmap

Non-critical things to do.

-   [ ] Make clicking on desktop hide all popups (system, calendar, menus)


## lib/


### `qubes.lua`

-   [ ] Use `awful.spawn.easy_async` instead of `io.popen` on line 119
-   [ ] Use `awful.spawn.with_line_callback` instead of `io.popen():lines()` on line 236


## Theme


### Solid vs. outline icons

Have the shell scripts supply slightly different icons based on the theme:

-   light theme -> outline icons
-   dark theme -> solid icons


### Widget underlines

Instead of setting widgets against a rounded rectangle backdrop, underline them with a line and remove the background.


## Widgets


### New

1.  Mouse finder popup

    Draw some wibox identifier (e.g. circle or ring) under mouse to help locate it. Possibly achieve an &ldquo;animation&rdquo; effect by drawing and then deleting ring of increasing radii.

2.  Status of camera and microphone

    Show something if they&rsquo;re attached to a VM (helps prevent forgetting to disconnect after use).

3.  System qubes status

    1.  &ldquo;Airplane mode&rdquo; button with status icon
    
        Detach all VMs attached to sys-net and shutdown sys-net
    
    2.  Simple ASCII network graph using unman&rsquo;s [viewer](https://github.com/unman/viewer)

4.  Qubes Elevator Pitch

    A popup that gives a basic outline of how Qubes OS works which you can use as a quick visual explanation tool. Also an excuse to use Ostrich Sans somewhere.
    
    This would cover all the basic points:
    
    1.  Compartmentalization -> VMs
    2.  Template system (read-only access security, shared root storage, quick VM creation, centralized updates)
    3.  Copy/Paste -> Global Clipboard
    4.  Inter VM communication -> Qrexec framework?
    5.  Device handling -> USB qube
    6.  Windows -> Windows HVM
    
    And list benefits of the Qubes setup and architecture:
    
    1.  Disposable VMs
    2.  Whonix integration
    3.  Split &ldquo;You-Name-It&rdquo;
    4.  Per-Qube networking

5.  Volume

    1.  Icon with percentage (like brightness)
    
    2.  Dropdown slider?


### Keyboard

1.  Compose key indicator

    I sometimes set the compose key to right control on a per-VM basis with `setxkbmap -option compose:rctrl`. This indicator will be yellow if active, and hovering over it will show a popup with the VMs in which the compose key is set to rctrl. This will require writing to a file the VMs with the active compose key (done in a separate script).

2.  Swap caps with escape

    When I find myself in Vim for prolonged periods (if my Emacs config is broken, for example), I swap the Escape key with the Caps Lock key. This indicator will be yellow if this is active, and hovering over it will show a popup with the VMs in which escape and capslock have been swapped. This will require writing to a file the VMs with the swapping (done in a separate script).


### Calendar

-   [ ] Add next/previous month toggles


### Tasklist

-   [ ] Make focused border appear only with more than one window in the workspace


### System

-   [ ] add restart button


### Qube count

-   [ ] Move to dropdown with text


### RAM

A text widget with total system RAM used.

-   [ ] Dropdown with dom0 RAM
-   [ ] Add domU RAM to dropdown


### Kernel

-   [ ] Add toggle for full version (5.15 -> 5.15.94-1)


### Battery

-   [ ] Send notification (sound?) every minute when battery reaches 10%


## Titlebars

-   [ ] Invert colors of icons (close window, tile, etc)
-   [ ] Pick more stylish icons
-   [ ] Draw inverted border around application icon


## Style

Use this command in Vim to help replace double quotes surrounding 0-4 character strings with single quotes, while avoiding double quotes with a comma in between (e.g. with comma-separated strings): `:%s/"\([^",]\{0,4}\)"/'\1'/g`.


# To Do

