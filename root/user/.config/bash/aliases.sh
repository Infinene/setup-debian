alias ls='ls -v --group --color=auto'
alias ll='lf'
alias ping='ping -c 4'
alias lps='ps -elf | grep'
alias sysctl-start='sudo systemctl start'
alias sysctl-restart='sudo systemctl restart'
alias sysctl-reload='sudo systemctl reload'
alias sysctl-stop='sudo systemctl stop'
alias sysctl-status='sudo systemctl status'
alias sysctl-enable='sudo systemctl status'
alias sysctl-disable='sudo systemctl status'
alias sysctl-daemon='sudo systemctl daemon-reload'

alias sudo='sudo -E '	#space at the end allows expansion of aliases when used with sudo
alias aptup='sudo apt update && sudo apt full-upgrade'
alias aptlist='sudo apt list --installed | pager'
alias aptsrch='apt search --names-only'
alias aptin='sudo apt install'

alias bat='bat --style=plain'
alias e='micro '

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
