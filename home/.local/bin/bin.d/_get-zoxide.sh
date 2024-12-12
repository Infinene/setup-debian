printf '%s\n'
printf '%s\n' "Updating zoxide..."

repo="ajeetdsouza/zoxide"

new_version=$(github_latest_release_num $repo)
if command -v zoxide &> /dev/null; then
  cur_version="$(zoxide -V | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
  cur_version="0.0"
fi
if [ "${cur_version}" = "${new_version}" ]; then
    printf '%s\n' "Already at latest version: zoxide $cur_version"
else
  eget -a amd64.deb -d $repo
  ${SUDO} dpkg -i zoxide*.deb
  rm zoxide*.deb
fi

grep -q -e 'zoxide' ~/.bashrc || echo 'eval "$(zoxide init --cmd cd bash)"' | tee -a ~/.bashrc

printf "Press enter to continue "
read key
