#!/bin/bash
# set -x

if [ "$(whoami)" != "root" ]; then
  SUDO=sudo
fi

setup_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

### install mailhog ###
LEGO_VER="$(curl -s "https://github.com/go-acme/lego/releases/latest" | grep -Eo "[0-9]+\.[0-9]+(\.[0-9]+)?")"
curl -Ls -O "https://github.com/go-acme/lego/releases/download/v${LEGO_VER}/lego_v${LEGO_VER}_linux_amd64.tar.gz"
tar -xf lego_v${LEGO_VER}_linux_amd64.tar.gz
${SUDO} mv -v ./lego /usr/local/bin/

echo 
echo 'Usage help:'
echo 'https://go-acme.github.io/lego/usage/cli/'
echo
echo 'Sample run:'
echo "GODADDY_API_KEY_FILE=path_to/godaddy.key \\"
echo "GODADDY_API_SECRET_FILE=path_to/godaddy.sec \\"
echo "lego -s https://acme-staging-v02.api.letsencrypt.org/directory \\"
echo "      --email email@example.com --dns godaddy \\"
echo "      -d domain.com -d '*.domain.com' run"