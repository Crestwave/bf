#!/usr/bin/env bash
LC_ALL=C
IFS=

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
	program=${MAPFILE[*]}
fi

program=${program//[^'><+-.,[]']}
(( tape[29999] = ptr = 0 ))

for (( i = 0; i < ${#program}; ++i )); do
	case ${program:i:1} in
		'>')
			(( ++ptr ))
			;;
		'<')
			(( --ptr ))
			;;
		'+')
			(( tape[ptr] = tape[ptr]+1 & 255 ))
			;;
		'-')
			(( tape[ptr] = tape[ptr]-1 & 255 ))
			;;
		'.')
			printf -v f %x "${tape[ptr]}"
			printf %b "\x$f"
			;;
		',')
			[[ -z $REPLY ]] && read -r && REPLY+=$'\n'

			[[ $REPLY ]] && {
				printf -v 'tape[ptr]' %d "'${REPLY::1}"
				REPLY=${REPLY:1}
			}
			;;
		'[')
			if (( tape[ptr] )); then
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
			(( ${#stack[@]} )) || die "unmatched ]"

			if (( tape[ptr] )); then
				(( i = stack[-1] ))
			else
				unset 'stack[-1]'
			fi
			;;
	esac
done

(( ! ${#stack[@]} )) || die "unmatched ["
