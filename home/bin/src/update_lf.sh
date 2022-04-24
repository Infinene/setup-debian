echo
echo "Updating lf..."

if command -v lf &> /dev/null
then
  local_version="$(lf -version)"
else
  local_version="0.0"
fi
        
version="$(curl -s "https://github.com/gokcehan/lf/releases/latest" | grep -Eo "r[0-9]+")"

if [ "$local_version" = "${version}" ]; then
    echo "Already at latest version: lf $local_version"
else
		echo "Updating lf version ${version}"
    # get the package
    file=lf-linux-${arch}.tar.gz
    curl -L https://github.com/gokcehan/lf/releases/latest/download/${file} | ${SUDO} tar xzC /usr/local/bin
    # if [ ! -f ~/.config/lf/lfrc ]; then
    #   mkdir -p ~/.config/lf
    #   curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/lfrc.example -o ~/.config/lf/lfrc
    # fi
fi
