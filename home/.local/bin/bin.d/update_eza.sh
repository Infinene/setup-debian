printf '%s\n'
printf '%s\n' "Updating eza..."

if command -v eza &> /dev/null
then
  cur_version="$(eza -v | grep -Eo "v[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
  cur_version="0.0"
fi

repo="eza-community/eza"
file="eza_x86_64-unknown-linux-gnu.tar.gz "
new_version="$(get_latest_release $repo)"

if [ "$cur_version" = "${new_version}" ]; then
    printf '%s\n' "Already at latest version: eza $cur_version"
else
		printf '%s\n' "Updating eza version ${new_version}"
    # get the package
    curl -L https://github.com/${repo}/releases/download/${new_version}/${file} | ${SUDO} tar xzC /usr/local/bin
fi
