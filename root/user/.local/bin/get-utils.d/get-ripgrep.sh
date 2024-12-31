printf '%s\n'
printf '%s\n' "Updating ripgrep..."

repo="BurntSushi/ripgrep"

new_version=$(github_latest_release_num $repo)
if command -v rg &> /dev/null; then
	cur_version="$(rg -V | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
	cur_version="0.0"
fi
if [ "${cur_version}" = "${new_version}" ]; then
	printf '%s\n' "Already at latest version: rg $cur_version"
else
	eget -a amd64.deb -d $repo
	${SUDO} dpkg -i ripgrep*.deb
	rm ripgrep*.deb
fi

read -rsn1 -p "Press any key to continue ... ";echo
