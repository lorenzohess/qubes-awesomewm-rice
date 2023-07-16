#!/bin/bash

# Show the size of the clipboard in human-readable bytes

# The global clipboard contents is in /var/run/qubes/qubes-clipboard.bin
# Handle this file AT YOUR OWN RISK.
# The only programmed interaction with the file in this script is the
# `stat` command used to find the size of the file. I'd welcome insight
# into the security risks of doing so.

icon='󱓥'
clipFile='/var/run/qubes/qubes-clipboard.bin'

if [ ! -e "$clipFile" ]; then 
	clipSizeHR='?'
else
	clipSize="$(stat --printf='%s' $clipFile)"

	if [[ "$clipSize" == '0' ]]; then
		clipSizeHumanReadable='0B'
	else
		clipSizeHumanReadable="$(echo $clipSize | numfmt --to=iec-i --suffix=B --format="%9f" | tr -d ' ')"
	fi
fi

echo "$icon $clipSizeHumanReadable"
