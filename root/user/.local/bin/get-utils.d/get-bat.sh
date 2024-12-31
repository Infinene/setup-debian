repo="sharkdp/bat"

printf '%s\n'
printf '%s\n' "Updating bat..."


new_version=$(github_latest_release_num $repo)
if command -v bat &> /dev/null; then
	cur_version="$(bat -V | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
	cur_version="0.0"
fi
if [ "${cur_version}" = "${new_version}" ]; then
	printf '%s\n' "Already at latest version: bat $cur_version"
else
	eget -a amd64.deb -a ^musl -d $repo
	${SUDO} dpkg -i bat*.deb
	rm bat*.deb
fi

printf "Press enter to continue "
read key
