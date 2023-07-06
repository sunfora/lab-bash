# simple 64 bit hexadecimal calculations

hex () ( 
    local args=( )
    while (( $# ))
    do
	[[ "$1" =~ ^[[:alnum:]]+$ ]] && 
	    args+=( "16#$1" )        ||
	    args+=( "$1" )
	shift	
    done
    printf '%016x\n' $(( ${args[@]} ))
)

