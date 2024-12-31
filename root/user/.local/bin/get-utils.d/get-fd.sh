printf '%s\n'
printf '%s\n' "Updating fd..."

repo="sharkdp/fd"


new_version=$(github_latest_release_num $repo)
if command -v fd &> /dev/null; then
	cur_version="$(fd -V | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
	cur_version="0.0"
fi
if [ "${cur_version}" = "${new_version}" ]; then
	printf '%s\n' "Already at latest version: fd $cur_version"
else
	eget -a amd64.deb -a ^musl -d $repo
	${SUDO} dpkg -i fd*.deb
	rm fd*.deb
fi

read -rsn1 -p "Press any key to continue ... ";echo
