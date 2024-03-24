KEEP_LINES=4000
create_log() {
    if [ -f $1 ]; then
        LOG=$(tail -n $KEEP_LINES $1 2>/dev/null) && printf '%s\n' "${LOG}" >$1
    fi
    exec > >(tee -a $1)
    exec 2>&1
}
log() {
    printf '%s\n' "[$(date +%Y-%m-%dT%H:%M:%S)] $*"
}
