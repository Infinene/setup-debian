echo
echo "Updating nnn..."

if command -v nnn &> /dev/null
then
  local_version="$(nnn -V)"
else
  local_version="0.0"
fi
        
version="$(curl -s "https://github.com/jarun/nnn/releases/latest" | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"

if [ "$local_version" = "${version}" ]; then
    echo "Already at latest version: nnn $local_version"
else
    # get the package
    file="nnn-static-${version}.x86_64.tar.gz"
    curl -Ls -O "https://github.com/jarun/nnn/releases/download/v${version}/${file}"
    tar -xf $file
    ${SUDO} mv nnn-static /usr/local/bin/nnn
    # remove the file
    rm -rf $file
fi