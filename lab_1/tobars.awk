BEGIN {
    special[60] = "E"

    lower[60] = "E"
    lower[67] = "D"
    lower[74] = "C"
    lower[83] = "B"
    lower[90] = "A"

    mm="FX"
    number="^[+-]?[[:digit:]]+([.][[:digit:]]+)?$"
}

{
    if (NF <= 3) {
       print "ERROR : invalid table at line", NR
       exit 1
    }
    # print names 
    for (i = 1; i < 4; ++i) {
        printf "%s%s", $i, OFS
    }

    # print grades
    for (i = 4; i <= NF; ++i) { 
        grade = mm
        if ($i in special) {
            grade = special[$i]
        } 
        else {
            mx = 0
            for (bound in lower) {
                if ((0 < $i - bound) && (0 < bound - mx)) {
                    grade = lower[bound]
                    mx = bound
                }
            }
        }
        printf "%s", grade
        if (i != NF) {
            printf "%s", OFS
        }
    }
    print ""
}
