alias l='ls --group --color=auto'
alias ll='ls -Alh --group --color=auto'
alias ping='ping -c 4'
alias lps='ps -elf | grep'
alias sctl='sudo stemctl'
alias sstart='sudo stemctl start'
alias srestart='sudo stemctl restart'
alias sreload='sudo stemctl reload'
alias sstop='sudo stemctl stop'
alias sstatus='sudo stemctl status'
alias senable='sudo stemctl enable'
alias sdisable='sudo stemctl disable'
alias sdaemon='sudo stemctl daemon-reload'

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
