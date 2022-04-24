echo
echo "Updating ripgrep..."

if command -v rg &> /dev/null
then
  local_version="$(rg -V)"
else
  local_version="0.0"
fi

version="$(curl -s "https://github.com/BurntSushi/ripgrep/releases/latest" | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"

if [ "$local_version" = "ripgrep ${version}" ]; then
    echo "Already at latest version: ${local_version}"
else
    # get the package
    file=ripgrep_${version}_${arch}.deb
    curl -Ls -O "https://github.com/BurntSushi/ripgrep/releases/download/${version}/${file}"
    # install it
    ${SUDO} dpkg -i $file
    # remove the file
    rm -rf $file
fi
