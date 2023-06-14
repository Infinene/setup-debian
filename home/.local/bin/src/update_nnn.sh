echo
echo "Updating nnn..."

if command -v nnn &> /dev/null
then
  CUR_VERSION="$(nnn -V)"
else
  CUR_VERSION="0.0"
fi
        
NEW_VERSION="$(curl -s "https://github.com/jarun/nnn/releases/latest" | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"

if [ "$CUR_VERSION" = "${NEW_VERSION}" ]; then
    echo "Already at latest version: nnn $CUR_VERSION"
else
    # get the package
    newfile="nnn-static-${NEW_VERSION}.x86_64.tar.gz"
    curl -Ls -O "https://github.com/jarun/nnn/releases/download/v${NEW_VERSION}/${newfile}"
    tar -xf $newfile
    ${SUDO} mv nnn-static /usr/local/bin/nnn
    # remove the file
    rm -rf $newfile
fi