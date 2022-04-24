echo
echo "Updating fd..."

if command -v fd &> /dev/null
then
  local_version="$(fd -V)"
else
  local_version="0.0"
fi

version="$(curl -s "https://github.com/sharkdp/fd/releases/latest" | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"

if [ "$local_version" = "fd ${version}" ]; then
    echo "Already at latest version: ${local_version}"
else
    # get the package
    file=fd_${version}_amd64.deb
    curl -Ls -O "https://github.com/sharkdp/fd/releases/download/v${version}/${file}"
    # install it
    ${SUDO} dpkg -i $file
    # remove the file
    rm -rf $file
fi
