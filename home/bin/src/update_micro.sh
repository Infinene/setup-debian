echo
echo "Updating micro editor..."

add_editor () {
  if ! update-alternatives --list editor | grep "micro" >/dev/null; then
    ${SUDO} update-alternatives --install /usr/bin/editor editor /usr/bin/micro 50
  fi
}

if command -v micro &> /dev/null
then
  local_version="$(micro -version | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
  local_version="0.0"
fi

version="$(curl -s "https://github.com/zyedidia/micro/releases/latest" | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"

if [ "$local_version" = "${version}" ]; then
    echo "Already at latest version: ${local_version}"
else
    # get the package
    file=micro-${version}-${arch}.deb
    curl -Ls -O "https://github.com/zyedidia/micro/releases/download/v${version}/${file}"
    # install it
    ${SUDO} dpkg -i $file
    # remove the file
    rm -vf $file
    add_editor
fi
