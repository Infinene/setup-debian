printf '%s\n'
printf '%s\n' "Updating ripgrep..."

repo="BurntSushi/ripgrep"

if command -v rg &> /dev/null
then
  cur_version="$(rg -V | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
  cur_version="0.0"
fi

new_version="$(get_latest_release_num $repo)"
file="ripgrep_${new_version}_${arch}.deb"

if [ "$cur_version" = "${new_version}" ]; then
    printf '%s\n' "Already at latest version: rg ${cur_version}"
else
    # get the package
    wget -nv --show-progress "https://github.com/${repo}/releases/download/${new_version}/${file}"
    # install it
    ${SUDO} dpkg -i $file
    # remove the file
    rm -vf $file
fi
