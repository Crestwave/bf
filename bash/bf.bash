#!/usr/bin/env bash

die()
{
	printf 'error: %s\n' "$@" >&2
	exit 1
}

if (( $# )); then
	if [[ -e $1 ]]; then
		program=$(< "$1")
	else
		die "file '$1' does not exist"
	fi
else
	mapfile -t
	program=${MAPFILE[@]}
fi

program=${program//[^'><+-.,[]']}
declare -A tape

for (( i = ptr = 0; i < ${#program}; ++i )); do
	case ${program:i:1} in
		'>')
			(( ++ptr ))
			;;
		'<')
			(( --ptr ))
			;;
		'+')
			(( ++tape['$ptr'] ))
			(( tape['$ptr'] > 255 )) && tape[$ptr]=0
			;;
		'-')
			(( --tape['$ptr'] ))
			(( tape['$ptr'] < 0 )) && tape[$ptr]=255
			;;
		'.')
			printf -v f %x "${tape[$ptr]}"
			printf %b "\x$f"
			;;
		',')
			[[ -z $REPLY ]] && IFS=$'\n' read -r && REPLY+=$'\n'

			[[ $REPLY ]] && {
				LC_CTYPE=C printf -v f %d "'${REPLY::1}"
				tape[$ptr]=$f
				REPLY=${REPLY:1}
			}
			;;
		'[')
			if (( tape['$ptr'] )); then
				stack+=("$i")
			else
				for (( depth = 1; depth > 0 && ++i; )); do
					case ${program:i:1} in
						'[') (( ++depth )) ;;
						']') (( --depth )) ;;
						'') die "unmatched [" ;;
					esac
				done
			fi
			;;
		']')
			(( _ = ${#stack[@]} )) || die "unmatched ]"

			if (( tape['$ptr'] )); then
				(( i = stack[_-1] ))
			else
				unset 'stack[_-1]'
			fi
			;;
	esac
done

(( ${#stack[@]} == 0 )) || die "unmatched ["
