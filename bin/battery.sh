#!/usr/bin/env bash

# Borrowed from qubes-i3status shipped with Qubes' i3.

status_bat() {
    local accum_now_mWh=0 # current battery power in mWh
    local accum_full_mWh=0 # full battery power in mWh

    local batteries # batteries connected to the system
    mapfile -t batteries < <(shopt -s nullglob; for f in /sys/class/power_supply/BAT*; do echo "$f"; done)
    for battery in "${batteries[@]}"; do
        if [ -f "${battery}"/energy_now ]; then
            accum_now_mWh=$((accum_now_mWh + $(cat "${battery}"/energy_now)))
            accum_full_mWh=$((accum_full_mWh + $(cat "${battery}"/energy_full)))
        elif [ -f $battery/charge_now ]; then
            # charge is given in mAh, convert to mWh
            local voltage=$(cat "${battery}"/voltage_now)
            local now_mWh=$(( (voltage / 1000) *  $(cat "${battery}"/charge_now) / 1000 ))
            local full_mWh=$(( (voltage / 1000) *  $(cat "${battery}"/charge_full) / 1000 ))

            accum_now_mWh=$((accum_now_mWh + now_mWh))
            accum_full_mWh=$((accum_full_mWh + full_mWh))
        fi
    done

    local bat_pct=$((100*accum_now_mWh/accum_full_mWh))

    local ac_present=false

    local adps # power adapters connected to the system
    mapfile -t adps < <(shopt -s nullglob; for f in /sys/class/power_supply/ADP* \
                                                    /sys/class/power_supply/AC* ; do echo "$f"; done)
    for adp in ${adps[@]}; do
        if [[ $(cat "${adp}"/online) == '1' ]]; then
            ac_present=true
        fi
    done

    local icon=''
    declare -a   batteryIcons=( 󰁺 󰁼 󰁾 󰂀 󰂂 󰁹 ) #  10, 30, 50, 70, 90, 100

    # Use a standalone charge icon because of issues with battery icons with
    # the integrated charge icon.
    if [[ "$ac_present" == true ]]; then
	    chargeIcon='󱐋'
    else
	    chargeIcon=''
    fi

    # Determine battery icon
    if ((bat_pct < 11)); then   # 0-10%
	    levelIdx=0
    elif ((bat_pct < 31)); then # 11-30%
	    levelIdx=1
    elif ((bat_pct < 51)); then # 31-50%
	    levelIdx=2
    elif ((bat_pct < 71)); then # 51-70%
	    levelIdx=3
    elif ((bat_pct < 91)); then # 71-90%
	    levelIdx=4
    else
	    levelIdx=5		# 91-100%
    fi

    icons="${batteryIcons[$levelIdx]}$chargeIcon"

    echo "$icons $bat_pct%"
}

status_bat
