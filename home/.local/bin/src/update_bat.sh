repo="sharkdp/bat"

echo
echo "Updating bat..."

if command -v bat &> /dev/null
then
  cur_version="$(bat -V | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
  cur_version="0.0"
fi

new_version="$(get_latest_release_num $repo)"
file="bat_${new_version}_${arch}.deb"

if [ "$cur_version" = "${new_version}" ]; then
    echo "Already at latest version: bat ${cur_version}"
else
    # get the package
    wget -nv --show-progress "https://github.com/${repo}/releases/download/v${new_version}/${file}"
    # install it
    ${SUDO} dpkg -i $file
    # remove the file
    rm -vf $file
fi
