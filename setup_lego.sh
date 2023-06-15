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

printf '%s\n' 
printf '%s\n' 'Usage help:'
printf '%s\n' 'https://go-acme.github.io/lego/usage/cli/'
printf '%s\n'
printf '%s\n' 'Sample run:'
printf '%s\n' "GODADDY_API_KEY_FILE=path_to/godaddy.key \\"
printf '%s\n' "GODADDY_API_SECRET_FILE=path_to/godaddy.sec \\"
printf '%s\n' "lego -s https://acme-staging-v02.api.letsencrypt.org/directory \\"
printf '%s\n' "      --email email@example.com --dns godaddy \\"
printf '%s\n' "      -d domain.com -d '*.domain.com' run"