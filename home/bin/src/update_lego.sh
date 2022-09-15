echo
echo "Updating lego..."

repo="go-acme/lego"

if command -v lego &> /dev/null
then
  cur_version="v$(lego -v | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
  cur_version="0.0"
fi

new_version="$(curl -s https://api.github.com/repos/${repo}/releases/latest | jq -r .tag_name )"
file="lego_${new_version}_linux_amd64.tar.gz"

if [ "$cur_version" = "${new_version}" ]; then
    echo "Already at latest version: ${cur_version}"
else
    # get the package
    curl -Ls https://github.com/${repo}/releases/download/${new_version}/${file} | ${SUDO} tar xzC /usr/local/bin
fi
