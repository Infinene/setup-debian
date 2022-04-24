echo
echo "Updating lego..."

if command -v lego &> /dev/null
then
  local_version="$(lego -v | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
  local_version="0.0"
fi

version="$(curl -s "https://github.com/go-acme/lego/releases/latest" | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"

if [ "$local_version" = "${version}" ]; then
    echo "Already at latest version: ${local_version}"
else
    # get the package
    file=lego_v${version}_linux_${arch}.tar.gz
    curl -Ls https://github.com/go-acme/lego/releases/download/v${version}/${file} | ${SUDO} tar xzC /usr/local/bin
fi
