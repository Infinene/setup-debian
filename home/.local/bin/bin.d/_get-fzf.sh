printf '%s\n'
printf '%s\n' "Updating fzf..."

repo="junegunn/fzf"


new_version=$(github_latest_release_num $repo)
if command -v fzf &> /dev/null; then
  cur_version="$(fzf --version | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
  cur_version="0.0"
fi
if [ "${cur_version}" = "${new_version}" ]; then
    printf '%s\n' "Already at latest version: fzf $cur_version"
else
  ${SUDO} eget -a amd64.tar.gz --to=/usr/local/bin $repo
fi

printf "Press enter to continue "
read key
