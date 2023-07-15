local awful = require("awful")

awful.spawn([[bash -c "pgrep -f -a qvm-start-daemon | grep -v $$ || dex-autostart -a -e XFCE"]]) -- very important!
awful.spawn.with_shell("/home/lhess/.config/awesome/bin/autorun.sh")

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
