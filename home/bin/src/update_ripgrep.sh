echo
echo "Updating ripgrep..."

repo="BurntSushi/ripgrep"

if command -v rg &> /dev/null
then
  cur_version="$(rg -V | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
  cur_version="0.0"
fi

new_version="$(curl -s https://api.github.com/repos/${repo}/releases/latest | jq -r .tag_name )"
file="ripgrep_${new_version}_${arch}.deb"

if [ "$cur_version" = "${new_version}" ]; then
    echo "Already at latest version: ${cur_version}"
else
    # get the package
    wget -nv --show-progress "https://github.com/${repo}/releases/download/${new_version}/${file}"
    # install it
    ${SUDO} dpkg -i $file
    # remove the file
    rm -vf $file
fi
