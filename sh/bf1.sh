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
					'')val=1;;'')val=2;;'')val=3;;'')val=4;;'')val=5;;'')val=6;;'')val=7;;'')val=8;;'	')val=9;;"$n")val=10;;'')val=11;;'')val=12;;'')val=13;;'')val=14;;'')val=15;;'')val=16;;'')val=17;;'')val=18;;'')val=19;;'')val=20;;'')val=21;;'')val=22;;'')val=23;;'')val=24;;'')val=25;;'')val=26;;'')val=27;;'')val=28;;'')val=29;;'')val=30;;'')val=31;;'')val=32;;'!')val=33;;'"')val=34;;'#')val=35;;'$')val=36;;'%')val=37;;'&')val=38;;"'")val=39;;'(')val=40;;')')val=41;;'*')val=42;;'+')val=43;;',')val=44;;'-')val=45;;'.')val=46;;'/')val=47;;'0')val=48;;'1')val=49;;'2')val=50;;'3')val=51;;'4')val=52;;'5')val=53;;'6')val=54;;'7')val=55;;'8')val=56;;'9')val=57;;':')val=58;;';')val=59;;'<')val=60;;'=')val=61;;'>')val=62;;'?')val=63;;'@')val=64;;'A')val=65;;'B')val=66;;'C')val=67;;'D')val=68;;'E')val=69;;'F')val=70;;'G')val=71;;'H')val=72;;'I')val=73;;'J')val=74;;'K')val=75;;'L')val=76;;'M')val=77;;'N')val=78;;'O')val=79;;'P')val=80;;'Q')val=81;;'R')val=82;;'S')val=83;;'T')val=84;;'U')val=85;;'V')val=86;;'W')val=87;;'X')val=88;;'Y')val=89;;'Z')val=90;;'[')val=91;;'\')val=92;;']')val=93;;'^')val=94;;'_')val=95;;'`')val=96;;'a')val=97;;'b')val=98;;'c')val=99;;'d')val=100;;'e')val=101;;'f')val=102;;'g')val=103;;'h')val=104;;'i')val=105;;'j')val=106;;'k')val=107;;'l')val=108;;'m')val=109;;'n')val=110;;'o')val=111;;'p')val=112;;'q')val=113;;'r')val=114;;'s')val=115;;'t')val=116;;'u')val=117;;'v')val=118;;'w')val=119;;'x')val=120;;'y')val=121;;'z')val=122;;'{')val=123;;'|')val=124;;'}')val=125;;'~')val=126;;'')val=127;;'�')val=128;;'�')val=129;;'�')val=130;;'�')val=131;;'�')val=132;;'�')val=133;;'�')val=134;;'�')val=135;;'�')val=136;;'�')val=137;;'�')val=138;;'�')val=139;;'�')val=140;;'�')val=141;;'�')val=142;;'�')val=143;;'�')val=144;;'�')val=145;;'�')val=146;;'�')val=147;;'�')val=148;;'�')val=149;;'�')val=150;;'�')val=151;;'�')val=152;;'�')val=153;;'�')val=154;;'�')val=155;;'�')val=156;;'�')val=157;;'�')val=158;;'�')val=159;;'�')val=160;;'�')val=161;;'�')val=162;;'�')val=163;;'�')val=164;;'�')val=165;;'�')val=166;;'�')val=167;;'�')val=168;;'�')val=169;;'�')val=170;;'�')val=171;;'�')val=172;;'�')val=173;;'�')val=174;;'�')val=175;;'�')val=176;;'�')val=177;;'�')val=178;;'�')val=179;;'�')val=180;;'�')val=181;;'�')val=182;;'�')val=183;;'�')val=184;;'�')val=185;;'�')val=186;;'�')val=187;;'�')val=188;;'�')val=189;;'�')val=190;;'�')val=191;;'�')val=192;;'�')val=193;;'�')val=194;;'�')val=195;;'�')val=196;;'�')val=197;;'�')val=198;;'�')val=199;;'�')val=200;;'�')val=201;;'�')val=202;;'�')val=203;;'�')val=204;;'�')val=205;;'�')val=206;;'�')val=207;;'�')val=208;;'�')val=209;;'�')val=210;;'�')val=211;;'�')val=212;;'�')val=213;;'�')val=214;;'�')val=215;;'�')val=216;;'�')val=217;;'�')val=218;;'�')val=219;;'�')val=220;;'�')val=221;;'�')val=222;;'�')val=223;;'�')val=224;;'�')val=225;;'�')val=226;;'�')val=227;;'�')val=228;;'�')val=229;;'�')val=230;;'�')val=231;;'�')val=232;;'�')val=233;;'�')val=234;;'�')val=235;;'�')val=236;;'�')val=237;;'�')val=238;;'�')val=239;;'�')val=240;;'�')val=241;;'�')val=242;;'�')val=243;;'�')val=244;;'�')val=245;;'�')val=246;;'�')val=247;;'�')val=248;;'�')val=249;;'�')val=250;;'�')val=251;;'�')val=252;;'�')val=253;;'�')val=254;;'�')val=255
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
