#!/bin/sh

if [ -e "$1" ]; then
	while IFS= read -r line; do
		prog=$prog$line
	done < "$1"
else
	while IFS= read -r line; do
		prog=$prog$line
	done
fi

IFS=' '
n='
'
val=0

while :; do
	case $prog in
		'>'*)
			set -- ${tape_right:-0}
			tape_left="$val $tape_left"
			val=$1
			shift
			tape_right=$*
			;;
		'<'*)
			set -- ${tape_left:-0}
			tape_right="$val $tape_right"
			val=$1
			shift
			tape_left=$*
			;;
		'+'*)
			val=$(( val + 1 ))
			[ "$val" -gt 255 ] && val=0
			;;
		'-'*)
			val=$(( val - 1 ))
			[ "$val" -lt 0 ] && val=255
			;;
		'.'*)
			printf "\\$(printf %o "$val")"
			;;
		','*)
			[ -z "$input" ] && IFS= read -r input && input=$input$n

			if [ -n "$input" ]; then
				val=$(
					LC_CTYPE=C
					printf %d "'${input%"${input#?}"}"
				)
				input=${input#?}
			fi
			;;
		'['*)
			if [ "$val" -eq 0 ]; then
				depth=1
				while :; do
					bak=${prog%"${prog#['><+-.,[]']}"}$bak
					prog=${prog#?}
					case $prog in
						'['*) depth=$(( depth + 1 )) ;;
						']'*) depth=$(( depth - 1 )) ;;
					esac
					[ "$depth" -le 0 ] && break
				done
			fi
			;;
		']'*)
			if [ "$val" -ne 0 ]; then
				depth=1
				while :; do
					case $bak in
						'['*) depth=$(( depth - 1 )) ;;
						']'*) depth=$(( depth + 1 )) ;;
					esac
					prog=${bak%"${bak#?}"}$prog
					bak=${bak#?}
					[ "$depth" -le 0 ] && break
				done
			fi
			;;
		'')
			break
			;;
	esac
	bak=${prog%"${prog#['><+-.,[]']}"}$bak
	prog=${prog#?}
done
