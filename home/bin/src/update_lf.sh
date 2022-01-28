echo
echo "Updating lf..."

if command -v lf &> /dev/null
then
  CUR_VERSION="$(lf -version)"
else
  CUR_VERSION="0.0"
fi
        
NEW_VERSION="$(curl -s "https://github.com/gokcehan/lf/releases/latest" | grep -Eo "r[0-9]+")"

if [ "$CUR_VERSION" = "${NEW_VERSION}" ]; then
    echo "Already at latest version: lf $CUR_VERSION"
else
		echo "Updating lf version ${NEW_VERSION}"
    # get the package
    curl -L https://github.com/gokcehan/lf/releases/latest/download/lf-linux-amd64.tar.gz | ${SUDO} tar xzC /usr/local/bin
    # if [ ! -f ~/.config/lf/lfrc ]; then
    #   mkdir -p ~/.config/lf
    #   curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/lfrc.example -o ~/.config/lf/lfrc
    # fi
fi
