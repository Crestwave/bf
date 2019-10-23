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
					'') val=1   ;; '€') val=128 ;;
					'') val=2   ;; '') val=129 ;;
					'') val=3   ;; '‚') val=130 ;;
					'') val=4   ;; 'ƒ') val=131 ;;
					'') val=5   ;; '„') val=132 ;;
					'') val=6   ;; '…') val=133 ;;
					'') val=7   ;; '†') val=134 ;;
					'') val=8   ;; '‡') val=135 ;;
					"$t") val=9   ;; 'ˆ') val=136 ;;
					"$n") val=10  ;; '‰') val=137 ;;
					'') val=11  ;; 'Š') val=138 ;;
					'') val=12  ;; '‹') val=139 ;;
					'') val=13  ;; 'Œ') val=140 ;;
					'') val=14  ;; '') val=141 ;;
					'') val=15  ;; 'Ž') val=142 ;;
					'') val=16  ;; '') val=143 ;;
					'') val=17  ;; '') val=144 ;;
					'') val=18  ;; '‘') val=145 ;;
					'') val=19  ;; '’') val=146 ;;
					'') val=20  ;; '“') val=147 ;;
					'') val=21  ;; '”') val=148 ;;
					'') val=22  ;; '•') val=149 ;;
					'') val=23  ;; '–') val=150 ;;
					'') val=24  ;; '—') val=151 ;;
					'') val=25  ;; '˜') val=152 ;;
					'') val=26  ;; '™') val=153 ;;
					'') val=27  ;; 'š') val=154 ;;
					'') val=28  ;; '›') val=155 ;;
					'') val=29  ;; 'œ') val=156 ;;
					'') val=30  ;; '') val=157 ;;
					'') val=31  ;; 'ž') val=158 ;;
					' ' ) val=32  ;; 'Ÿ') val=159 ;;
					'!' ) val=33  ;; ' ') val=160 ;;
					'"' ) val=34  ;; '¡') val=161 ;;
					'#' ) val=35  ;; '¢') val=162 ;;
					'$' ) val=36  ;; '£') val=163 ;;
					'%' ) val=37  ;; '¤') val=164 ;;
					'&' ) val=38  ;; '¥') val=165 ;;
					"'" ) val=39  ;; '¦') val=166 ;;
					'(' ) val=40  ;; '§') val=167 ;;
					')' ) val=41  ;; '¨') val=168 ;;
					'*' ) val=42  ;; '©') val=169 ;;
					'+' ) val=43  ;; 'ª') val=170 ;;
					',' ) val=44  ;; '«') val=171 ;;
					'-' ) val=45  ;; '¬') val=172 ;;
					'.' ) val=46  ;; '­') val=173 ;;
					'/' ) val=47  ;; '®') val=174 ;;
					'0' ) val=48  ;; '¯') val=175 ;;
					'1' ) val=49  ;; '°') val=176 ;;
					'2' ) val=50  ;; '±') val=177 ;;
					'3' ) val=51  ;; '²') val=178 ;;
					'4' ) val=52  ;; '³') val=179 ;;
					'5' ) val=53  ;; '´') val=180 ;;
					'6' ) val=54  ;; 'µ') val=181 ;;
					'7' ) val=55  ;; '¶') val=182 ;;
					'8' ) val=56  ;; '·') val=183 ;;
					'9' ) val=57  ;; '¸') val=184 ;;
					':' ) val=58  ;; '¹') val=185 ;;
					';' ) val=59  ;; 'º') val=186 ;;
					'<' ) val=60  ;; '»') val=187 ;;
					'=' ) val=61  ;; '¼') val=188 ;;
					'>' ) val=62  ;; '½') val=189 ;;
					'?' ) val=63  ;; '¾') val=190 ;;
					'@' ) val=64  ;; '¿') val=191 ;;
					'A' ) val=65  ;; 'À') val=192 ;;
					'B' ) val=66  ;; 'Á') val=193 ;;
					'C' ) val=67  ;; 'Â') val=194 ;;
					'D' ) val=68  ;; 'Ã') val=195 ;;
					'E' ) val=69  ;; 'Ä') val=196 ;;
					'F' ) val=70  ;; 'Å') val=197 ;;
					'G' ) val=71  ;; 'Æ') val=198 ;;
					'H' ) val=72  ;; 'Ç') val=199 ;;
					'I' ) val=73  ;; 'È') val=200 ;;
					'J' ) val=74  ;; 'É') val=201 ;;
					'K' ) val=75  ;; 'Ê') val=202 ;;
					'L' ) val=76  ;; 'Ë') val=203 ;;
					'M' ) val=77  ;; 'Ì') val=204 ;;
					'N' ) val=78  ;; 'Í') val=205 ;;
					'O' ) val=79  ;; 'Î') val=206 ;;
					'P' ) val=80  ;; 'Ï') val=207 ;;
					'Q' ) val=81  ;; 'Ð') val=208 ;;
					'R' ) val=82  ;; 'Ñ') val=209 ;;
					'S' ) val=83  ;; 'Ò') val=210 ;;
					'T' ) val=84  ;; 'Ó') val=211 ;;
					'U' ) val=85  ;; 'Ô') val=212 ;;
					'V' ) val=86  ;; 'Õ') val=213 ;;
					'W' ) val=87  ;; 'Ö') val=214 ;;
					'X' ) val=88  ;; '×') val=215 ;;
					'Y' ) val=89  ;; 'Ø') val=216 ;;
					'Z' ) val=90  ;; 'Ù') val=217 ;;
					'[' ) val=91  ;; 'Ú') val=218 ;;
					'\' ) val=92  ;; 'Û') val=219 ;;
					']' ) val=93  ;; 'Ü') val=220 ;;
					'^' ) val=94  ;; 'Ý') val=221 ;;
					'_' ) val=95  ;; 'Þ') val=222 ;;
					'`' ) val=96  ;; 'ß') val=223 ;;
					'a' ) val=97  ;; 'à') val=224 ;;
					'b' ) val=98  ;; 'á') val=225 ;;
					'c' ) val=99  ;; 'â') val=226 ;;
					'd' ) val=100 ;; 'ã') val=227 ;;
					'e' ) val=101 ;; 'ä') val=228 ;;
					'f' ) val=102 ;; 'å') val=229 ;;
					'g' ) val=103 ;; 'æ') val=230 ;;
					'h' ) val=104 ;; 'ç') val=231 ;;
					'i' ) val=105 ;; 'è') val=232 ;;
					'j' ) val=106 ;; 'é') val=233 ;;
					'k' ) val=107 ;; 'ê') val=234 ;;
					'l' ) val=108 ;; 'ë') val=235 ;;
					'm' ) val=109 ;; 'ì') val=236 ;;
					'n' ) val=110 ;; 'í') val=237 ;;
					'o' ) val=111 ;; 'î') val=238 ;;
					'p' ) val=112 ;; 'ï') val=239 ;;
					'q' ) val=113 ;; 'ð') val=240 ;;
					'r' ) val=114 ;; 'ñ') val=241 ;;
					's' ) val=115 ;; 'ò') val=242 ;;
					't' ) val=116 ;; 'ó') val=243 ;;
					'u' ) val=117 ;; 'ô') val=244 ;;
					'v' ) val=118 ;; 'õ') val=245 ;;
					'w' ) val=119 ;; 'ö') val=246 ;;
					'x' ) val=120 ;; '÷') val=247 ;;
					'y' ) val=121 ;; 'ø') val=248 ;;
					'z' ) val=122 ;; 'ù') val=249 ;;
					'{' ) val=123 ;; 'ú') val=250 ;;
					'|' ) val=124 ;; 'û') val=251 ;;
					'}' ) val=125 ;; 'ü') val=252 ;;
					'~' ) val=126 ;; 'ý') val=253 ;;
					'') val=127 ;; 'þ') val=254 ;;
					         'ÿ') val=255
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
