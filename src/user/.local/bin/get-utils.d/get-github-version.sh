github_latest_release() {
	# api based (rate limited to 60/hr, but fastest)
	curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
		grep '"tag_name":' |                                            # Get tag line
		sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value

	# web url based
	# curl -Ls -o /dev/null -w %{url_effective} https://github.com/$1/releases/latest |
	#   grep -o "tag/.*" | cut -d '/' -f 2
}

github_latest_release_num() {
	github_latest_release $1 |
	grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?"                            # Pluck numeric value only
}
