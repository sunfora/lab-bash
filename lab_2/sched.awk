BEGIN {
    stat["sum_exec_runtime"] = "" 
    stat["nr_switches"] = ""
}

{
    for (field in stat) {
        if ($1 ~ field) {
	    stat[field] = $2
        }
    }
}

END {
    print stat["sum_exec_runtime"] / stat["nr_switches"]
}
