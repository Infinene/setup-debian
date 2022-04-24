echo
echo "Updating bat..."

if command -v bat &> /dev/null
then
  local_version="$(bat -V | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
  local_version="0.0"
fi

version="$(curl -s "https://github.com/sharkdp/bat/releases/latest" | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"

if [ "$local_version" = "${version}" ]; then
    echo "Already at latest version: ${version}"
else
  # get the package
  file=bat_${version}_${arch}.deb
  curl -Ls -O "https://github.com/sharkdp/bat/releases/download/v${version}/${file}"
  # install it
  if [ -f $file ]; then
    ${SUDO} dpkg -i $file
    # remove the file
    rm -rf $file
  else
    echo "ERROR: File ${file} not found."
  fi
fi