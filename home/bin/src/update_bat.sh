echo
echo "Updating bat..."

if command -v bat &> /dev/null
then
  CUR_VERSION="$(bat -V | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
  CUR_VERSION="0.0"
fi

NEW_VERSION="$(curl -s "https://github.com/sharkdp/bat/releases/latest" | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"

if [ "$CUR_VERSION" = "${NEW_VERSION}" ]; then
    echo "Already at latest version: ${CUR_VERSION}"
else
    # get the package
    curl -Ls -O "https://github.com/sharkdp/bat/releases/download/v${NEW_VERSION}/bat_${NEW_VERSION}_amd64.deb"
    # install it
    ${SUDO} dpkg -i bat_"${NEW_VERSION}"_amd64.deb
    # remove the file
    rm -rf bat_"${NEW_VERSION}"_amd64.deb
fi