printf '%s\n'
printf '%s\n' "Updating zoxide..."

repo="ajeetdsouza/zoxide"

if command -v zoxide &> /dev/null; then
  cur_version="$(zoxide -V | grep -Eo '[0-9]+\.[0-9]+(\.[0-9]+)?')"
else
  cur_version="0.0"
fi

new_version=$(github_latest_release_num $repo)
file="zoxide_${new_version}-1_${arch}.deb"

if [ "$cur_version" = "$new_version" ]; then
    printf '%s\n' "Already at latest version: ${cur_version}"
else
    # get the package
    wget -nv --show-progress "https://github.com/${repo}/releases/download/v${new_version}/${file}"
    # install it
    ${SUDO} dpkg -i $file
    # remove the file
    rm -vf $file
    grep -q -e 'zoxide init' ~/.bashrc ||
        printf "\neval \"\$(zoxide init --cmd cd bash)\"" | tee -a ~/.bashrc
fi
