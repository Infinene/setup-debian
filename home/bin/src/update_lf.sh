echo
echo "Updating lf..."

if command -v lf &> /dev/null
then
  cur_version="$(lf -version)"
else
  cur_version="0.0"
fi

repo="gokcehan/lf"
file="lf-linux-${arch}.tar.gz"    
# new_version="$(curl -s https://api.github.com/repos/${repo}/releases/latest | jq -r .tag_name)"
new_version="$(get_latest_release $repo)"

if [ "$cur_version" = "${new_version}" ]; then
    echo "Already at latest version: lf $cur_version"
else
		echo "Updating lf version ${new_version}"
    # get the package
    curl -L https://github.com/${repo}/releases/download/${new_version}/lf-linux-amd64.tar.gz | ${SUDO} tar xzC /usr/local/bin
    if [ ! -f ~/.config/lf/lfrc ]; then
      echo "Copying sample lfrc in ~/.config/lf/ ..."
      mkdir -p ~/.config/lf
      curl https://raw.githubusercontent.com/${repo}/master/etc/lfrc.example -o ~/.config/lf/lfrc
    fi
fi
