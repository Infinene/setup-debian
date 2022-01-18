#!/bin/bash
# set -x

if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi

setup_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

${SUDO} apt -y install samba

${SUDO} cp -bv $setup_dir/etc/samba/* /etc/samba/

echo
echo 'Edit /etc/samba/smb.conf for user names and shares'
echo "Add users with: smbpasswd -a $USER"
echo "Restart nmbd and smbd services"