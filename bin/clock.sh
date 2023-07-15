#!/bin/bash

# Get twelve hour time and strip leading zero
hour="$(date +%I | tr -d 0)" 

# Get clock icon
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

echo "$clock"
