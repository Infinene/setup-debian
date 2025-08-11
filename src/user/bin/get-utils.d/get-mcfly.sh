printf '%s\n'
printf '%s\n' "Updating mcfly..."
# set-x

repo="cantino/mcfly"

${SUDO} eget -a x86_64 -a linux --upgrade-only --to=/usr/local/bin $repo

read -rsn1 -p "Press any key to continue... ";echo
