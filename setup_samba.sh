#!/bin/sh
# set -x

if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi

setup_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

${SUDO} apt -y install samba

${SUDO} cp -bv $setup_dir/etc/samba/* /etc/samba/

printf '%s\n'
printf '%s\n' 'Edit /etc/samba/smb.conf for user names and shares'
printf '%s\n' "Add users with: smbpasswd -a $USER"
printf '%s\n' "Restart nmbd and smbd services"