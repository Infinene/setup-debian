echo
echo "Updating fd..."

if command -v fd &> /dev/null
then
  CUR_VERSION="$(fd -V)"
else
  CUR_VERSION="0.0"
fi

NEW_VERSION="$(curl -s "https://github.com/sharkdp/fd/releases/latest" | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"

if [ "$CUR_VERSION" = "fd ${NEW_VERSION}" ]; then
    echo "Already at latest version: ${CUR_VERSION}"
else
    # get the package
    curl -Ls -O "https://github.com/sharkdp/fd/releases/download/v${NEW_VERSION}/fd_${NEW_VERSION}_amd64.deb"
    # install it
    ${SUDO} dpkg -i fd_"${NEW_VERSION}"_amd64.deb
    # remove the file
    rm -rf fd_"${NEW_VERSION}"_amd64.deb
fi
