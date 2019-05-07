#!/usr/bin/env bash
LC_ALL=C
IFS=

if (( $# )); then
	while (( $# )); do
		program+=$(< "$1") || exit
		shift
	done
else
	mapfile -t
	program=${MAPFILE[*]}
fi

program=${program//[^'><+-.,[]']}
IFS= read -d "" -r translation <<'EOF'
declare -A tape
ptr=0

i()
{
	[[ -z $REPLY ]] && read -r && REPLY+=$'\n'

	[[ $REPLY ]] && {
		LC_CTYPE=C printf -v 'tape[$ptr]' %d "'${REPLY::1}"
		REPLY=${REPLY:1}
	}
}

o()
{
	local hex
	printf -v hex %x "${tape[$ptr]}"
	printf %b "\x$hex"
}
EOF

for (( i = 0; i < ${#program}; ++i )); do
	case ${program:i:1} in
		'>'): '(( ++ptr ))' ;;
		'<'): '(( --ptr ))' ;;
		'+'): '(( tape[$ptr] = tape[$ptr]+1 & 255 ))' ;;
		'-'): '(( tape[$ptr] = tape[$ptr]-1 & 255 ))' ;;
		'.'): 'o' ;;
		','): 'i' ;;
		'['): 'while (( tape[$ptr] )); do :' ;;
		']'): 'done' ;;
	esac
	translation+=$_$'\n'
done

eval "$translation"$'\n:' || exit
