#!/usr/bin/env tclsh

if {$argc > 0} {
    foreach arg $argv {
        set f [open $arg r]
        append program [read $f]
        close $f
    }
} else {
    set program [read stdin]
}

regsub -all {[^><+\-.,[\]]} $program "" program
set program [split $program ""]
set len [llength $program]
set trans "set p 0"
set open_brace "{"
set close_brace "}"

for {set i 0} {$i < $len} {incr i} {
    switch -- [lindex $program $i] {
        > { append trans {
            incr p 1
        }}
        < { append trans {
            incr p -1
        }}
        + { append trans {
            if {[incr a($p) 1] == 256} {
                set a($p) 0
            }
        }}
        - { append trans {
            if {[incr a($p) -1] == -1} {
                set a($p) 255
            }
        }}
        . { append trans {
            puts -nonewline [format %c [incr a($p) 0]]
        }}
        , { append trans {
            if {[set c [read stdin 1]] ne ""} {
                set a($p) [scan $c %c]
            }
        }}
        [ {
            append trans "\n        "
            append trans {while {[incr a($p) 0]}}
            append trans " $open_brace"
        }
        ] {
            append trans $close_brace
        }
    }
}

fconfigure stdout -buffering none
eval $trans
