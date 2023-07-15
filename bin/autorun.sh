#!/bin/sh

autorun() {
	if ! pgrep -f "$1" ;
	then
		$@ &
	fi
}

if [[ "$(whoami)" == "lhess" ]]; then
	bash -c "xinput --set-prop 'PNP0C50:00 04F3:311D Touchpad' 'libinput Tapping Enabled' 1"
	bash -c "xinput --set-prop 'ETPS/2 Elantech Touchpad' 'libinput Tapping Enabled' 1"
	autorun 'xset r rate 300 50'
	autorun /home/lhess/scripts/startup.sh
	autorun 'qvm-start sys-vpn-proton'
fi
