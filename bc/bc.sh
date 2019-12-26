#!/bin/sh
LC_ALL=C
n='
'

while read -r line; do
	prog=$prog$line
done < "$1" || exit

while [ -n "$prog" ]; do
	c=${prog%"${prog#?}"}
	prog=${prog#?}
	case $c in
		["><+-.,[]"])
			program=$program$(printf %d "'$c")$n
	esac
done

program=${program}33$n

dir=${0%/}
dir=${dir%%/*}

{
	printf %s "$program"
	while input=; do
		if read -r line; then
			eof=0
		else
			[ -z "$line" ] && break
			eof=1
		fi

		while [ -n "$line" ]; do
			input=$input$(printf %d "'${line%"${line#?}"}")$n
			line=${line#?}
		done

		printf %s "$input"
		if [ "$eof" = 0 ]; then
			printf '10\n'
		else
			break
		fi
	done
	printf -- '-1\n'
} | "$dir"/bf.bc | {
	while read -r line; do
		printf "\\$(printf %o "$line")"
	done

	kill -s 13 0
}
