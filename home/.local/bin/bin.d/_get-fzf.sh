printf '%s\n'
printf '%s\n' "Updating fzf..."

repo="junegunn/fzf"

if command -v fzf &> /dev/null; then
  cur_version="$(fzf --version | grep -Eo '[0-9]+\.[0-9]+(\.[0-9]+)?')"
else
  cur_version="0.0"
fi

new_version=$(github_latest_release_num $repo)
file="fzf-${new_version}-linux_${arch}.tar.gz"

if [ "$cur_version" = "$new_version" ]; then
    printf '%s\n' "Already at latest version: ${cur_version}"
else
    # get the package
   curl -L "https://github.com/${repo}/releases/download/${new_version}/${file}" | ${SUDO} tar xzC /usr/local/bin
fi
