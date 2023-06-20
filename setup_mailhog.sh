#!/bin/sh
# set -x

if [ "$(whoami)" != "root" ]; then
  SUDO=sudo
fi

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

if grep -i microsoft /proc/version; then
  is_wsl=true
else
  is_wsl=false
fi

setup_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

### install mailhog ###
mailhog_ver=$(get_latest_release 'mailhog/MailHog')
curl -Ls -O "https://github.com/mailhog/MailHog/releases/download/${mailhog_ver}/MailHog_linux_amd64"
chmod +x ./MailHog_linux_amd64
${SUDO} mv ./MailHog_linux_amd64 /usr/local/bin/mailhog

${SUDO} cp -v $setup_dir/misc/mhsendmail /usr/local/bin/


if [ "$is_wsl" = true ]; then
    printf '%s\n' "Installing in WSL!"
    ${SUDO} apt install daemonize
    ${SUDO} cp -v $setup_dir/misc/wsl_mailhog_init /etc/init.d/mailhog
    ${SUDO} service mailhog start
    ${SUDO} service mailhog status
else
    printf '%s\n' "Installing systemd service"
    ${SUDO} cp -v $setup_dir/misc/mailhog.service /lib/systemd/system/
    ${SUDO} systemctl enable mailhog
    ${SUDO} systemctl start mailhog
    ${SUDO} systemctl status mailhog
fi

mhsendmail test@localhost <<EOF
From: Setup <setup@mailhog.local>
To: Test <test@localhost>
Subject: Mailhog installed

Setup completed successfully!
EOF