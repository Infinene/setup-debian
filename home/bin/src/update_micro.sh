echo
echo "Updating fd..."

add_editor () {
  if ! update-alternatives --list editor | grep "micro" >/dev/null; then
    ${SUDO} update-alternatives --install /usr/bin/editor editor /usr/bin/micro 50
  fi
}

if command -v micro &> /dev/null
then
  CUR_VERSION="$(micro -version | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
  CUR_VERSION="0.0"
fi

NEW_VERSION="$(curl -s "https://github.com/zyedidia/micro/releases/latest" | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"

if [ "$CUR_VERSION" = "${NEW_VERSION}" ]; then
    echo "Already at latest version: ${CUR_VERSION}"
else
    # get the package
    curl -Ls -O "https://github.com/zyedidia/micro/releases/download/v${NEW_VERSION}/micro-${NEW_VERSION}-amd64.deb"
    # install it
    ${SUDO} dpkg -i micro-"${NEW_VERSION}"-amd64.deb
    # remove the file
    rm -vf micro-"${NEW_VERSION}"-amd64.deb
    add_editor
fi
