#!/bin/bash

grepCount() {
	echo "$(echo "$2" | grep -cF "$1")"
}

# VM data
vms="$(qvm-ls --running --raw-data --fields name,class)"
names="$(echo "$vms" | awk -F'|' '{print $1}')"
classes="$(echo "$vms" | awk -F'|' '{print $2}')"

# Counts
total="$(echo "$vms" | wc -l)" # includes dom0
n_templates=$(grepCount 'TemplateVM' "$classes")
n_dvms=$(grepCount 'DispVM' "$classes")
n_sys=$(grepCount 'sys-' "$names")

# disp vms:  󰂵 󰂶 󱛑 󱔼 󰚠 󱝊
echo "$total $n_sys $n_dvms 󰀿$n_templates"
