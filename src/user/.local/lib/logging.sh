KEEP_LINES=10000
initialize_logfile() {
	[ "$#" -eq 1 ] || die "logfile path/name required."
	if [ ! -f "$logfile" ]; then
		file="$(basename $logfile)"
		dir="$(dirname $logfile)"
		mkdir -p "${dir}" && touch "$logfile"
	fi
	if [ -f $1 ]; then
		LOG=$(tail -n $KEEP_LINES $1 2>/dev/null) && printf '%s\n' "${LOG}" >$1
	fi
}

start_logging() {
	logile=$1
	if [ ! -f "$logfile" ] || [ $(wc -l < $logfile) -gt $KEEP_LINES ]; then
		initialize_logfile $logfile
	fi
	exec 4>&1
	exec > >(tee -a $logfile)
	exec 2>&1
}

stop_logging() {
	exec 1>&4
	exec 4>&-
}

log() {
	printf '%s\n' "$(date '+%Y-%m-%d %H:%M:%S') $*"
}
