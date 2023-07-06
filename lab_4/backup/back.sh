digits () {
    echo "[[:digit:]]{$1}"
}

generate_formats () {
    local name="$1"
    local format="$2"
    eval "${name}_DATE_FORMAT=$format"
    eval "${name}_BACKUP_FORMAT='Backup-$format'"
}

generate_formats GREP "`digits 4`-`digits 2`-`digits 2`"
generate_formats DATE "%Y-%m-%d" 

list_directories () {
    echo "list_directories: $1"
    find "$1"             \
        -mindepth 1       \
        -maxdepth 1       \
        -type d           \
        -not -path '*/.*' \
        -printf '%f\n'
}

list_backups () {
    list_directories "$1" | egrep "$GREP_BACKUP_FORMAT"
}

last_backup () {
    list_backups "$1" | sort | tail -1
}

last_backup_time () {
    last_backup "$1" | egrep -o "$GREP_DATE_FORMAT"
}

