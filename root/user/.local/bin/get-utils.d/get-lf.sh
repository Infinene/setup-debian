printf '%s\n'
printf '%s\n' "Updating lf..."

if command -v lf &> /dev/null
then
	cur_version="$(lf -version)"
else
	cur_version="0.0"
fi

repo="gokcehan/lf"


file="lf-linux-${arch}.tar.gz"
new_version="$(github_latest_release $repo)"

if [ "${cur_version}" = "${new_version}" ]; then
	printf '%s\n' "Already at latest version: lf $cur_version"
else
	${SUDO} eget -a linux-amd64.tar.gz --to=/usr/local/bin $repo
fi

read -rsn1 -p "Press any key to continue ... ";echo
