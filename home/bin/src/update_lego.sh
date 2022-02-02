echo
echo "Updating lego..."

if command -v lego &> /dev/null
then
  CUR_VERSION="$(lego -v | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
  CUR_VERSION="0.0"
fi

NEW_VERSION="$(curl -s "https://github.com/go-acme/lego/releases/latest" | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"

if [ "$CUR_VERSION" = "${NEW_VERSION}" ]; then
    echo "Already at latest version: ${CUR_VERSION}"
else
    # get the package
    curl -Ls https://github.com/go-acme/lego/releases/download/v${NEW_VERSION}/lego_v${NEW_VERSION}_linux_amd64.tar.gz | ${SUDO} tar xzC /usr/local/bin
fi
