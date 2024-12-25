printf '%s\n'
printf '%s\n' "Updating mcfly..."
# set-x

repo="cantino/mcfly"

${SUDO} eget -a x86_64 -a linux --upgrade-only --to=/usr/local/bin $repo
grep -q -e 'mcfly' ~/.bashrc || echo 'eval "$(mcfly init bash)"' | tee -a ~/.bashrc

printf "Press enter to continue "
read key
