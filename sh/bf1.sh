#!/bin/sh
LC_ALL=C \
IFS='	
' \
n='
' \
tape_right=0 \
tape_left=0 \
val=0 \
prog= \
bak=

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
					'')val=1;;'')val=2;;'')val=3;;'')val=4;;'')val=5;;'')val=6;;'')val=7;;'')val=8;;'	')val=9;;"$n")val=10;;'')val=11;;'')val=12;;'')val=13;;'')val=14;;'')val=15;;'')val=16;;'')val=17;;'')val=18;;'')val=19;;'')val=20;;'')val=21;;'')val=22;;'')val=23;;'')val=24;;'')val=25;;'')val=26;;'')val=27;;'')val=28;;'')val=29;;'')val=30;;'')val=31;;'')val=32;;'!')val=33;;'"')val=34;;'#')val=35;;'$')val=36;;'%')val=37;;'&')val=38;;"'")val=39;;'(')val=40;;')')val=41;;'*')val=42;;'+')val=43;;',')val=44;;'-')val=45;;'.')val=46;;'/')val=47;;'0')val=48;;'1')val=49;;'2')val=50;;'3')val=51;;'4')val=52;;'5')val=53;;'6')val=54;;'7')val=55;;'8')val=56;;'9')val=57;;':')val=58;;';')val=59;;'<')val=60;;'=')val=61;;'>')val=62;;'?')val=63;;'@')val=64;;'A')val=65;;'B')val=66;;'C')val=67;;'D')val=68;;'E')val=69;;'F')val=70;;'G')val=71;;'H')val=72;;'I')val=73;;'J')val=74;;'K')val=75;;'L')val=76;;'M')val=77;;'N')val=78;;'O')val=79;;'P')val=80;;'Q')val=81;;'R')val=82;;'S')val=83;;'T')val=84;;'U')val=85;;'V')val=86;;'W')val=87;;'X')val=88;;'Y')val=89;;'Z')val=90;;'[')val=91;;'\')val=92;;']')val=93;;'^')val=94;;'_')val=95;;'`')val=96;;'a')val=97;;'b')val=98;;'c')val=99;;'d')val=100;;'e')val=101;;'f')val=102;;'g')val=103;;'h')val=104;;'i')val=105;;'j')val=106;;'k')val=107;;'l')val=108;;'m')val=109;;'n')val=110;;'o')val=111;;'p')val=112;;'q')val=113;;'r')val=114;;'s')val=115;;'t')val=116;;'u')val=117;;'v')val=118;;'w')val=119;;'x')val=120;;'y')val=121;;'z')val=122;;'{')val=123;;'|')val=124;;'}')val=125;;'~')val=126;;'')val=127;;'€')val=128;;'')val=129;;'‚')val=130;;'ƒ')val=131;;'„')val=132;;'…')val=133;;'†')val=134;;'‡')val=135;;'ˆ')val=136;;'‰')val=137;;'Š')val=138;;'‹')val=139;;'Œ')val=140;;'')val=141;;'Ž')val=142;;'')val=143;;'')val=144;;'‘')val=145;;'’')val=146;;'“')val=147;;'”')val=148;;'•')val=149;;'–')val=150;;'—')val=151;;'˜')val=152;;'™')val=153;;'š')val=154;;'›')val=155;;'œ')val=156;;'')val=157;;'ž')val=158;;'Ÿ')val=159;;' ')val=160;;'¡')val=161;;'¢')val=162;;'£')val=163;;'¤')val=164;;'¥')val=165;;'¦')val=166;;'§')val=167;;'¨')val=168;;'©')val=169;;'ª')val=170;;'«')val=171;;'¬')val=172;;'­')val=173;;'®')val=174;;'¯')val=175;;'°')val=176;;'±')val=177;;'²')val=178;;'³')val=179;;'´')val=180;;'µ')val=181;;'¶')val=182;;'·')val=183;;'¸')val=184;;'¹')val=185;;'º')val=186;;'»')val=187;;'¼')val=188;;'½')val=189;;'¾')val=190;;'¿')val=191;;'À')val=192;;'Á')val=193;;'Â')val=194;;'Ã')val=195;;'Ä')val=196;;'Å')val=197;;'Æ')val=198;;'Ç')val=199;;'È')val=200;;'É')val=201;;'Ê')val=202;;'Ë')val=203;;'Ì')val=204;;'Í')val=205;;'Î')val=206;;'Ï')val=207;;'Ð')val=208;;'Ñ')val=209;;'Ò')val=210;;'Ó')val=211;;'Ô')val=212;;'Õ')val=213;;'Ö')val=214;;'×')val=215;;'Ø')val=216;;'Ù')val=217;;'Ú')val=218;;'Û')val=219;;'Ü')val=220;;'Ý')val=221;;'Þ')val=222;;'ß')val=223;;'à')val=224;;'á')val=225;;'â')val=226;;'ã')val=227;;'ä')val=228;;'å')val=229;;'æ')val=230;;'ç')val=231;;'è')val=232;;'é')val=233;;'ê')val=234;;'ë')val=235;;'ì')val=236;;'í')val=237;;'î')val=238;;'ï')val=239;;'ð')val=240;;'ñ')val=241;;'ò')val=242;;'ó')val=243;;'ô')val=244;;'õ')val=245;;'ö')val=246;;'÷')val=247;;'ø')val=248;;'ù')val=249;;'ú')val=250;;'û')val=251;;'ü')val=252;;'ý')val=253;;'þ')val=254;;'ÿ')val=255
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
