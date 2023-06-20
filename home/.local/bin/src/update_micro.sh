echo
echo "Updating micro editor..."

repo="zyedidia/micro"
micro_dir='/usr/local/bin'

setup_alternatives () {
  if ! update-alternatives --list editor | grep "micro" >/dev/null; then
    ${SUDO} update-alternatives --install /usr/bin/editor editor ${micro_dir}/micro 50
  else
    sudo update-alternatives --set editor ${micro_dir}/micro
  fi
}

if command -v micro &> /dev/null; then
  cur_version="$(micro -version | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
elif [ -f ~/.local/bin/micro ]; then
  cur_version="$(~/.local/bin/micro -version | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
  if [ ! -f /usr/local/bin/micro ]; then
      printf "move to /usr/local/bin ...\n"
      sudo mv $HOME/.local/bin/micro /usr/local/bin/
      setup_alternatives
  fi
else
  cur_version="0.0"
fi

new_version="$(get_latest_release_num $repo)"
file=micro-"${new_version}-${arch}.deb"

if [ "${cur_version}" \> "${new_version}" ] || [ "${cur_version}" = "${new_version}" ]; then
    printf "Already at latest version: micro ${cur_version}\n"
else
    # get the package
    wget -nv --show-progress "https://github.com/${repo}/releases/download/v${new_version}/${file}"
    # install it
    ${SUDO} dpkg -i $file
    # remove the file
    rm -vf $file
    setup_alternatives
    echo "remove local version from ~/.local/bin if installed ..."
    printf "Press enter to continue "
    read key
fi

