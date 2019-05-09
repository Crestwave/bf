#!/usr/bin/env tclsh

if {$argc > 0} {
    set f [open [lindex $argv 0] r]
    set program [read $f]
    close $f
} else {
    set program [read stdin]
}

fconfigure stdout -buffering none

regsub -all {[^><+\-.,[\]]} $program "" program
set program [split $program ""]
set len [llength $program]
set stack ""
set ptr 0

for {set i -200} {$i < 30000} {incr i} {
    set tape($i) 0
}

for {set i 0} {$i < $len} {incr i} {
    switch -- [lindex $program $i] {
        > {
            incr ptr 1
        }
        < {
            incr ptr -1
        }
        + {
            if {[incr tape($ptr) 1] == 256} {
                set tape($ptr) 0
            }
        }
        - {
            if {[incr tape($ptr) -1] == -1} {
                set tape($ptr) 255
            }
        }
        . {
            puts -nonewline [format %c $tape($ptr)]
        }
        , {
            set c [read stdin 1]
            if {$c ne ""} {
                set tape($ptr) [scan $c %c]
            }
        }
        \[ {
            if {$tape($ptr)} {
                lappend stack $i
            } else {
                for {set depth 1} {$depth > 0} {incr i} {
                    switch -- [lindex $program $i+1] {
                        \[ {
                            incr depth 1
                        }
                        \] {
                            incr depth -1
                        }
                        "" {
                            error "missing close-bracket"
                        }
                    }
                }
            }
        }
        \] {
            if {$stack eq ""} {
                error "missing open-bracket"
            }

            if {$tape($ptr)} {
                set i [lindex $stack end]
            } else {
                set stack [lrange $stack 0 end-1]
            }
        }
    }
}

if {$stack ne ""} {
    error "missing close-bracket"
}
