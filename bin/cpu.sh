#!/bin/bash

# Widget to display CPU load as percentage.

# bytes=" --suffix=B --to=iec-i "

_xen_info() {
	# Need 1s delay and two iterations because for some reason,
	# xentop doesn't show CPU percentage until the second iteration.
	# NOTE: if the delay is less than 1s, dom0's CPU percentage
	# skyrockets to more than 100%.
	echo "$(xentop -b -d 1 -i 2 | tail -n +2)"
}

_format() {
	echo "$(numfmt $1 --format=%$2.$3f)"
}

xen_cpu_load="$(_xen_info | grep Domain-0 | awk '{print $4}' | _format '' 2 0)"

echo "$xen_cpu_load%"
