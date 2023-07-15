#!/bin/bash

# Widget to display information about how much RAM is being used.

bytes=" --suffix=B --to=iec-i "

_xen_info() {
	echo "$(xentop -b -i 1 | tail -n +2)"
}

_format() {
	echo "$(numfmt $1 --format=%$2.$3f)"
}

xen_mem_pct="$(_xen_info | awk '{sum += $6} END {print sum}' | _format '' 2 1)" # 97
xen_mem_val="$(_xen_info | awk '{sum += $5} END {print sum * 1024}' | _format "$bytes" 2 1)" # 24.7GiB

if [ "$1" == 'show' ]; then
	echo "󰘚$xen_mem_pct% $xen_mem_val"
else
	echo "󰘚$xen_mem_val"
fi
