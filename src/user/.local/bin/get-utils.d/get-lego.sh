printf '%s\n'
printf '%s\n' "Updating lego..."

repo="go-acme/lego"

new_version=$(github_latest_version_num $repo)
if command -v lego &> /dev/null; then
	cur_version="$(lego -v | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
	cur_version="0.0"
fi
if [ "${cur_version}" = "${new_version}" ]; then
	printf '%s\n' "Already at latest version: lego $cur_version"
else
	${SUDO} eget -a amd64.tar.gz --to=/usr/local/bin $repo
fi

read -rsn1 -p "Press any key to continue... ";echo
