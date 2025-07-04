printf '%s\n'
printf '%s\n' "Updating eget..."

repo="zyedidia/eget"

new_version=$(github_latest_version_num $repo)
if command -v eget &> /dev/null; then
	cur_version="$(eget -v | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
	if [ "$cur_version" = "${new_version}" ]; then
		printf '%s\n' "Already at latest version: eget $cur_version"
	else
		${SUDO} eget --to=/usr/local/bin $repo
	fi
else
	cur_version="0.0"
	curl https://zyedidia.github.io/eget.sh | sh
	${SUDO} mv eget /usr/local/bin/
fi
