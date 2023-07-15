#!/bin/bash

brightness="$(cat /sys/class/backlight/intel_backlight/brightness)"
maxBrightness="$(cat /sys/class/backlight/intel_backlight/max_brightness)" # should be 48000
percentvalue="$(echo "$brightness/$maxBrightness" | bc -l | head -c 3)"

# Get percentage value
if [ $percentvalue == '1.0' ]; then
	percent='100%'
else
	percent="$(echo $percentvalue | tr -d .)%"
fi

# Get icon
if [ "$brightness" == "$maxBrightness" ]; then
	icon='󰃠'
elif [ "$brightness" -gt $(( $maxBrightness / 2 )) ]; then
	icon='󰃟'
else
	icon='󰃞'
fi

echo "$icon $percent"
