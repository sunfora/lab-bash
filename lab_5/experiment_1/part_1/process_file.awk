#!/usr/bin/gawk -f 
BEGIN {
    FS = ","
    ind[3] = "mem"
    ind[4] = "swap"
    ind[7] = "data"
    ind[8] = "end"
}

{
    j = i % 9
    if (j in ind) {
	switch (ind[j]) {
	    case "mem":
	    case "swap":
	    	gsub("free", "", $2)
	        printf "%s ", $2
	        break
	    case "data":
	        printf "%s", $0
	        break
	    case "end":
	        printf "\n"
	        break
	}
    }

    i++
}
