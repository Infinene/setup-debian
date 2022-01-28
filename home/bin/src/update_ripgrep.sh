echo
echo "Updating ripgrep..."

if command -v rg &> /dev/null
then
  CUR_VERSION="$(rg -V)"
else
  CUR_VERSION="0.0"
fi

NEW_VERSION="$(curl -s "https://github.com/BurntSushi/ripgrep/releases/latest" | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"

if [ "$CUR_VERSION" = "ripgrep ${NEW_VERSION}" ]; then
    echo "Already at latest version: ${CUR_VERSION}"
else
    # get the package
    curl -Ls -O "https://github.com/BurntSushi/ripgrep/releases/download/${NEW_VERSION}/ripgrep_${NEW_VERSION}_amd64.deb"
    # install it
    ${SUDO} dpkg -i ripgrep_"${NEW_VERSION}"_amd64.deb
    # remove the file
    rm -rf ripgrep_"${NEW_VERSION}"_amd64.deb
fi
