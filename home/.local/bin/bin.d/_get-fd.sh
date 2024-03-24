printf '%s\n'
printf '%s\n' "Updating fd..."

repo="sharkdp/fd"

if command -v fd &> /dev/null
then
  cur_version="$(fd -V)"
else
  cur_version="0.0"
fi

new_version=$(github_latest_release_num $repo)
file="fd_${new_version}_${arch}.deb"

if [ "$cur_version" = "fd ${new_version}" ]; then
    printf '%s\n' "Already at latest version: ${cur_version}"
else
    # get the package
    wget -nv --show-progress "https://github.com/${repo}/releases/download/v${new_version}/${file}"
    # install it
    ${SUDO} dpkg -i $file
    # remove the file
    rm -vf $file
fi
