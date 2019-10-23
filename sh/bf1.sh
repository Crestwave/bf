#!/bin/sh
LC_ALL=C \
IFS='	
' \
t='	' \
n='
' \
tape_right=0 \
tape_left=0 \
val=0

read_prog()
while read -r line || case $line in '')break; esac; do
	prog=$prog$line
done


case $# in 0)
	read_prog
;;*)
	read_prog < "$1" || exit
esac

IFS=
while case : in '')esac; do
	case $prog in
		'>'*)
			tape_left="$val $tape_left" \
			val=${tape_right%% *} \
			tape_right=${tape_right#* }
			;;
		'<'*)
			tape_right="$val $tape_right" \
			val=${tape_left%% *} \
			tape_left=${tape_left#* }
			;;
		'+'*)
			val=$(( val+1 & 255 ))
			;;
		'-'*)
			val=$(( val-1 & 255 ))
			;;
		'.'*)
			printf \\$(( val / 64 ))$(( val/8 & 7 ))$(( val & 7 ))
			;;
		','*)
			case $input in '')
				read -r input && input=$input$n
			esac

			case $input in ?*)
				case ${input%"${input#?}"} in
					'') val=1   ;; '�') val=128 ;;
					'') val=2   ;; '�') val=129 ;;
					'') val=3   ;; '�') val=130 ;;
					'') val=4   ;; '�') val=131 ;;
					'') val=5   ;; '�') val=132 ;;
					'') val=6   ;; '�') val=133 ;;
					'') val=7   ;; '�') val=134 ;;
					'') val=8   ;; '�') val=135 ;;
					"$t") val=9   ;; '�') val=136 ;;
					"$n") val=10  ;; '�') val=137 ;;
					'') val=11  ;; '�') val=138 ;;
					'') val=12  ;; '�') val=139 ;;
					'') val=13  ;; '�') val=140 ;;
					'') val=14  ;; '�') val=141 ;;
					'') val=15  ;; '�') val=142 ;;
					'') val=16  ;; '�') val=143 ;;
					'') val=17  ;; '�') val=144 ;;
					'') val=18  ;; '�') val=145 ;;
					'') val=19  ;; '�') val=146 ;;
					'') val=20  ;; '�') val=147 ;;
					'') val=21  ;; '�') val=148 ;;
					'') val=22  ;; '�') val=149 ;;
					'') val=23  ;; '�') val=150 ;;
					'') val=24  ;; '�') val=151 ;;
					'') val=25  ;; '�') val=152 ;;
					'') val=26  ;; '�') val=153 ;;
					'') val=27  ;; '�') val=154 ;;
					'') val=28  ;; '�') val=155 ;;
					'') val=29  ;; '�') val=156 ;;
					'') val=30  ;; '�') val=157 ;;
					'') val=31  ;; '�') val=158 ;;
					' ' ) val=32  ;; '�') val=159 ;;
					'!' ) val=33  ;; '�') val=160 ;;
					'"' ) val=34  ;; '�') val=161 ;;
					'#' ) val=35  ;; '�') val=162 ;;
					'$' ) val=36  ;; '�') val=163 ;;
					'%' ) val=37  ;; '�') val=164 ;;
					'&' ) val=38  ;; '�') val=165 ;;
					"'" ) val=39  ;; '�') val=166 ;;
					'(' ) val=40  ;; '�') val=167 ;;
					')' ) val=41  ;; '�') val=168 ;;
					'*' ) val=42  ;; '�') val=169 ;;
					'+' ) val=43  ;; '�') val=170 ;;
					',' ) val=44  ;; '�') val=171 ;;
					'-' ) val=45  ;; '�') val=172 ;;
					'.' ) val=46  ;; '�') val=173 ;;
					'/' ) val=47  ;; '�') val=174 ;;
					'0' ) val=48  ;; '�') val=175 ;;
					'1' ) val=49  ;; '�') val=176 ;;
					'2' ) val=50  ;; '�') val=177 ;;
					'3' ) val=51  ;; '�') val=178 ;;
					'4' ) val=52  ;; '�') val=179 ;;
					'5' ) val=53  ;; '�') val=180 ;;
					'6' ) val=54  ;; '�') val=181 ;;
					'7' ) val=55  ;; '�') val=182 ;;
					'8' ) val=56  ;; '�') val=183 ;;
					'9' ) val=57  ;; '�') val=184 ;;
					':' ) val=58  ;; '�') val=185 ;;
					';' ) val=59  ;; '�') val=186 ;;
					'<' ) val=60  ;; '�') val=187 ;;
					'=' ) val=61  ;; '�') val=188 ;;
					'>' ) val=62  ;; '�') val=189 ;;
					'?' ) val=63  ;; '�') val=190 ;;
					'@' ) val=64  ;; '�') val=191 ;;
					'A' ) val=65  ;; '�') val=192 ;;
					'B' ) val=66  ;; '�') val=193 ;;
					'C' ) val=67  ;; '�') val=194 ;;
					'D' ) val=68  ;; '�') val=195 ;;
					'E' ) val=69  ;; '�') val=196 ;;
					'F' ) val=70  ;; '�') val=197 ;;
					'G' ) val=71  ;; '�') val=198 ;;
					'H' ) val=72  ;; '�') val=199 ;;
					'I' ) val=73  ;; '�') val=200 ;;
					'J' ) val=74  ;; '�') val=201 ;;
					'K' ) val=75  ;; '�') val=202 ;;
					'L' ) val=76  ;; '�') val=203 ;;
					'M' ) val=77  ;; '�') val=204 ;;
					'N' ) val=78  ;; '�') val=205 ;;
					'O' ) val=79  ;; '�') val=206 ;;
					'P' ) val=80  ;; '�') val=207 ;;
					'Q' ) val=81  ;; '�') val=208 ;;
					'R' ) val=82  ;; '�') val=209 ;;
					'S' ) val=83  ;; '�') val=210 ;;
					'T' ) val=84  ;; '�') val=211 ;;
					'U' ) val=85  ;; '�') val=212 ;;
					'V' ) val=86  ;; '�') val=213 ;;
					'W' ) val=87  ;; '�') val=214 ;;
					'X' ) val=88  ;; '�') val=215 ;;
					'Y' ) val=89  ;; '�') val=216 ;;
					'Z' ) val=90  ;; '�') val=217 ;;
					'[' ) val=91  ;; '�') val=218 ;;
					'\' ) val=92  ;; '�') val=219 ;;
					']' ) val=93  ;; '�') val=220 ;;
					'^' ) val=94  ;; '�') val=221 ;;
					'_' ) val=95  ;; '�') val=222 ;;
					'`' ) val=96  ;; '�') val=223 ;;
					'a' ) val=97  ;; '�') val=224 ;;
					'b' ) val=98  ;; '�') val=225 ;;
					'c' ) val=99  ;; '�') val=226 ;;
					'd' ) val=100 ;; '�') val=227 ;;
					'e' ) val=101 ;; '�') val=228 ;;
					'f' ) val=102 ;; '�') val=229 ;;
					'g' ) val=103 ;; '�') val=230 ;;
					'h' ) val=104 ;; '�') val=231 ;;
					'i' ) val=105 ;; '�') val=232 ;;
					'j' ) val=106 ;; '�') val=233 ;;
					'k' ) val=107 ;; '�') val=234 ;;
					'l' ) val=108 ;; '�') val=235 ;;
					'm' ) val=109 ;; '�') val=236 ;;
					'n' ) val=110 ;; '�') val=237 ;;
					'o' ) val=111 ;; '�') val=238 ;;
					'p' ) val=112 ;; '�') val=239 ;;
					'q' ) val=113 ;; '�') val=240 ;;
					'r' ) val=114 ;; '�') val=241 ;;
					's' ) val=115 ;; '�') val=242 ;;
					't' ) val=116 ;; '�') val=243 ;;
					'u' ) val=117 ;; '�') val=244 ;;
					'v' ) val=118 ;; '�') val=245 ;;
					'w' ) val=119 ;; '�') val=246 ;;
					'x' ) val=120 ;; '�') val=247 ;;
					'y' ) val=121 ;; '�') val=248 ;;
					'z' ) val=122 ;; '�') val=249 ;;
					'{' ) val=123 ;; '�') val=250 ;;
					'|' ) val=124 ;; '�') val=251 ;;
					'}' ) val=125 ;; '�') val=252 ;;
					'~' ) val=126 ;; '�') val=253 ;;
					'') val=127 ;; '�') val=254 ;;
					         '�') val=255
				esac
				input=${input#?}
			esac
			;;
		'['*)
			case $val in 0)
				depth=1
				while case $depth in 0)break; esac; do
					bak=${prog%"${prog#["><+-.,[]"]}"}$bak \
					prog=${prog#?}
					case $prog in
						']'*) depth=$(( depth - 1 )) ;;
						'['*) depth=$(( depth + 1 )) ;;
					esac
				done
			esac
			;;
		']'*)
			case $val in 0);;*)
				depth=1
				while case $depth in 0)break; esac; do
					case $bak in
						'['*) depth=$(( depth - 1 )) ;;
						']'*) depth=$(( depth + 1 )) ;;
					esac
					prog=${bak%"${bak#?}"}$prog \
					bak=${bak#?}
				done
			esac
			;;
		'')
			break
			;;
		*)
			prog=${prog#?}
			continue
	esac
	bak=${prog%"${prog#?}"}$bak \
	prog=${prog#?}
done
