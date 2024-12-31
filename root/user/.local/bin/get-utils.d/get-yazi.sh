printf '%s\n'
printf '%s\n' "Updating yazi..."

repo="sxyazi/yazi"

new_version=$(github_latest_release_num $repo)
if command -v yazi &> /dev/null; then
	cur_version="$(yazi --version | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
else
	cur_version="0.0"
fi
if [ "${cur_version}" = "${new_version}" ]; then
	printf '%s\n' "Already at latest version: yazi $cur_version"
else
	eget -a x86_64-unknown-linux-gnu.zip -d $repo
	unzip yazi*.zip
	${SUDO} cp yazi*/ya* /usr/local/bin
	${SUDO} cp yazi*/completions/*.bash /etc/bash_completion.d/
	rm -r yazi*
fi

read -rsn1 -p "Press any key to continue ... ";echo
