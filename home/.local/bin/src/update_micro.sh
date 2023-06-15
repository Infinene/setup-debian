printf '%s\n'
printf '%s\n' "Updating micro editor..."

repo="zyedidia/micro"

setup_alternatives () {
  if ! update-alternatives --list editor | grep "micro" >/dev/null; then
    ${SUDO} update-alternatives --install /usr/bin/editor editor /usr/bin/micro 50
  else
    sudo update-alternatives --set editor /usr/bin/micro
  fi
}

if command -v micro &> /dev/null
then
  cur_version="$(micro -version | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
  cur_version="0.0"
fi

new_version="$(get_latest_release_num $repo)"
file=micro-"${new_version}-${arch}.deb"

if [ "$cur_version" = "${new_version}" ]; then
    printf '%s\n' "Already at latest version: micro ${cur_version}"
else
    # get the package
    wget -nv --show-progress "https://github.com/${repo}/releases/download/v${new_version}/${file}"
    # install it
    ${SUDO} dpkg -i $file
    # remove the file
    rm -vf $file
    setup_alternatives
fi

