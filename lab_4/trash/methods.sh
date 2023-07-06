# common methods for trash structure
SOURCE_DIR=$(dirname $(realpath ${BASH_SOURCE:-0}))
eval source `find $SOURCE_DIR -name hex.sh`

trash:check_structure () {
    [[ -d $1/links ]] && 
    [[ -f $1/log   ]] && 
    [[ -f $1/lock  ]] &&
    [[ -f $1/last  ]] && {
        echo "$1"
	return 0 
    } || {
	echo "Bad structure" > /dev/stderr
        return 1
    }
}

trash:open () {
    local dest="${1:-$HOME}"
    [[ ! -d $dest ]] && {
        echo "Not a valid destination $dest" > /dev/stderr
        return 1
    }

    local this="$dest/.trash"

    mkdir -- "$this" 2> /dev/null
    local not_created=$?

    # quit if already created
    (( $not_created )) && [[ -d $this ]] && { 
        trash:check_structure "$this"
        return $?
    }

    # fail not due to existance
    (( $not_created )) && {
	echo "Failed to create trash at $dest" > /dev/stderr
    	return 1
    }

    touch -- "$this/lock"
    mkdir -- "$this/links"
    echo "id path name" > "$this/log"
    hex -1 > "$this/last"

    trash:check_structure "$this"
    return $?
}

trash:next_id () {
    local id=$(cat -- "$1/last")
    hex $id + 1 > "$1/last"
    echo $(cat -- "$1/last")
}

trash:add_file () {
    local path="$2"
    local name="$3"
    local id=$(trash:next_id "$1")
    {
	mv -- "$path/$name" "$1/links/$id" &&
        trash:write_log "$1" "$id" "$path" "$name"
    } || {
	echo "Unable to add file"
    	exit 1
    }

}

trash:__last_group_log () {
# retrieves last write in log for each id
    gawk '
    #get last line in each group 
    {
        group[$1]=$0
    } 
    END {
        for (id in group) {
	    print group[id]
	}
    }' <(tail -n +2 "$1/log")
}

trash:actual () {
# retrieves logs for existing files 
    join --nocheck-order                          \
	    <(trash:__last_group_log "$1" | sort) \
	    <(ls -1 "$1/links" | sort) 
}

trash:write_log () {
# write id, path, name to log
    local id="$2"
    local path=`trash:encode "$3"`
    local name=`trash:encode "$4"`
    echo $id $path $name >> "$1/log"
}

trash:encode () {
    base64 <<< "$1" | tr -d \\n
}

trash:decode () {
    base64 --decode <<< "$1"
}

trash:__resolve_name_conflict () {
   local full="$1"
   local path="$2"
   local name="$3"

   while [[ -e ${!full} ]]
   do
	echo "Such file already exists"
	read -p "Rename: " $name 
	eval "$full='${!path}/${!name}'"
   done
}

trash:restore_file () {
    local id="$1"
    local path="$2"
    local name="$3"

    local full="$path/$name"

    trash:__resolve_name_conflict full path name

    # if path does not exist
    if [[ ! -d $path ]]; then 
        echo "Cannot restore file at ${path@Q}"
  	echo "Changing path to ${HOME@Q}"
  	path="$HOME"
  	full="$path/$name"
    fi
  
    mv -- "$this/links/$id" "$full"
    return $?
}

