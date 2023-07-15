#!/bin/bash

# Calendar Icon
# 
# 󰸗
# 󰸘
# 
calendar_icon=''

# Twelve hour time and strip leading zero
date="$(date +'%a %b %d')"
time="$(date +'%-I:%M %p')" # hyphen disables padding with 0
hour="$(date +'%-I')" 

case $hour in
	1) clock='󱐿'
		;;
	2) clock='󱑀'
		;;
	3) clock='󱑁'
		;;
	4) clock='󱑂'
		;;
	5) clock='󱑃'
		;;
	6) clock='󱑄'
		;;
	7) clock='󱑅'
		;;
	8) clock='󱑆'
		;;
	9) clock='󱑇'
		;;
	10) clock='󱑈'
		;;
	11) clock='󱑉'
		;;
	12) clock='󱑊'
		;;
esac

echo "$calendar_icon $date, $clock $time" 
#echo "$date $calendar_icon, $time $clock " 
