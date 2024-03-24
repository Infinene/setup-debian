printf '%s\n'
printf '%s\n' "Updating lego..."

repo="go-acme/lego"

if command -v lego &> /dev/null
then
  cur_version="$(lego -v | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
  cur_version="0.0"
fi

new_version="$(get_latest_release_num $repo)"
file="lego_v${new_version}_linux_amd64.tar.gz"

if [ "$cur_version" = "${new_version}" ]; then
    printf '%s\n' "Already at latest version: lego ${cur_version}"
else
    # get the package
    https://github.com/go-acme/lego/releases/download/v4.8.0/lego_v4.8.0_linux_amd64.tar.gz
    curl -Ls https://github.com/${repo}/releases/download/v${new_version}/${file} | ${SUDO} tar xzC /usr/local/bin
fi
