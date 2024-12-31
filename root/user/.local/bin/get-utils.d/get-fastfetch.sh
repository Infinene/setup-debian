echo
echo "Updating fastfetch..."

repo="fastfetch-cli/fastfetch"

new_version=$(github_latest_release_num $repo)
if command -v fd &> /dev/null; then
	cur_version="$(fastfetch -v | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
	cur_version="0.0"
fi
if [ "${cur_version}" = "${new_version}" ]; then
	printf '%s\n' "Already at latest version: fastfetch $cur_version"
else
	eget -a amd64.deb $repo
	${SUDO} dpkg -i fastfetch*.deb
	rm fastfetch*.deb
fi

read -rsn1 -p "Press any key to continue ... ";echo
