alias l='ls --group --color=auto'
alias ll='ls -Alh --group --color=auto'
alias ping='ping -c 4'
alias lps='ps -elf | grep'
alias sysctl='sudo systemctl'
alias sys-start='sudo systemctl start'
alias sys-restart='sudo systemctl restart'
alias sys-reload='sudo systemctl reload'
alias sys-stop='sudo systemctl stop'
alias sys-status='sudo systemctl status'
alias sys-enable='sudo systemctl status'
alias sys-disable='sudo systemctl status'
alias sys-daemon='sudo systemctl daemon-reload'

alias sudo='sudo -E '	#space at the end allows expansion of aliases when used with sudo
alias aptup='sudo apt update && sudo apt full-upgrade'
alias aptlist='sudo apt list --installed | pager'
alias aptsrch='apt search --names-only'
alias aptin='sudo apt install'

alias bat='bat --style=plain'
alias e='micro '
alias nginxmod='sudo nginxmod'

# view a file
v() {
	local dir=$(dirname "${1}")
	dir=${dir:-$(pwd)}
	[ ! -w "${dir}" ] && local SUDO=true
	${SUDO:+sudo} bat --style=plain $1
}

# monitor a log/text file
m() {
	local dir=$(dirname "${1}")
	dir=${dir:-$(pwd)}
	[ ! -w "${dir}" ] && local SUDO=true
	${SUDO:+sudo} less -N +F $1
}
