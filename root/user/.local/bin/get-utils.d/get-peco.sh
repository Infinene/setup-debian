printf '%s\n'
printf '%s\n' "Updating peco..."
# set-x

repo="peco/peco"

${SUDO} eget -a linux_amd64 --upgrade-only --to=/usr/local/bin $repo

printf "Press enter to continue "
read key
