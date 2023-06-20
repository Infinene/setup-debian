printf '%s\n'
printf '%s\n' "Updating micro editor..."

repo="zyedidia/micro"
bin_dir="/usr/local/bin"

setup_alternatives () {
  if ! update-alternatives --list editor | grep "micro" >/dev/null; then
    ${SUDO} update-alternatives --install ${bin_dir} editor ${bin_dir}/micro 50
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

if [ "${cur_version}" \> "${new_version}" ] || [ "${cur_version}" = "${new_version}" ]; then
    printf '%s\n' "Already at latest version: micro ${cur_version}"
    if [ ! -f /usr/local/bin/micro ]; then
	      printf "micro setup ...\n"
	      sudo ln -s $HOME/.local/bin/micro /usr/local/bin/
        setup_alternatives
    fi
else
    # get the package
    wget -nv --show-progress "https://github.com/${repo}/releases/download/v${new_version}/${file}"
    # install it
    ${SUDO} dpkg -i $file
    # remove the file
    rm -vf $file
    setup_alternatives
fi

