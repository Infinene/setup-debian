echo
echo "Updating ripgrep..."

if [[ $arch == "arm"* ]]; then
  echo "arm arhictecture not supported - install using apt"
  exit
fi

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
  if [ -f $file ]; then
    ${SUDO} dpkg -i $file
    # remove the file
    rm -rf $file
  else
    echo "ERROR: File ${file} not found."
  fi
fi
