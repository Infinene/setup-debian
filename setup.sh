#!/bin/bash
# set -x

setup_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

userid=$(id -u)
mariadb_ver='10.11'
php_ver='8.2'

if grep -i microsoft /proc/version; then
  is_wsl=true
else
  is_wsl=false
fi

if [ "$(id -u)" -eq 0 ]; then
    tput setaf 1;
    printf "\nRunning as root! User environment and utilities will not be setup.\n"
    tput init
    printf "Launch as a user in sudo group for complete setup.\n"
    while true
    do
        printf "Continue as root user (y/n)? "
        read choice
        case "$choice" in
        y|Y )   break;;
        n|N )   exit
                break;;
        * )     echo "please enter y/Y or n/N"
                ;;
        esac
    done
else
    SUDO=sudo
    ${SUDO} echo 
fi

. $setup_dir/misc/utils.sh

msg=$(printf "This will setup basic web servers\nSelect what to install:")
selection=$(
whiptail --title "Debian Web Server Setup" --checklist \
"$msg" 8 0 0 \
Shell "Setup user shell environment and utilities" 1 \
MariaDB "Install MariaDb $mariadb_ver" 1 \
Nginx "Install latest Nginx" 0 \
PHP "Install php $php_ver" 0 \
3>&2 2>&1 1>&3
);

exitstatus=$?
if [ $exitstatus != 0 ] || [ "x$selection" = "x" ]; then
    echo "Nothing selected!"
    exit
fi

if instr "Shell" "$selection"; then
    echo "---"
    echo "Continue with shell setup ..."
    printf "Press enter to continue"
    read key
    . $setup_dir/setup.d/_shell.sh
fi

if instr "MariaDB" "$selection"; then
    echo "---"
    echo "Continue with installing MariaDB ${mariadb_ver} ..."
    printf "Press enter to continue"
    read key
    . $setup_dir/setup.d/_mariadb.sh
fi

if instr "Nginx" "$selection"; then
    echo "---"
    echo "Continue with installing Nginx"
    printf "Press enter to continue"
    read key
    . $setup_dir/setup.d/_nginx.sh
fi

if instr "PHP" "$selection"; then
    echo "---"
    echo "Continue with installing PHP ${php_ver}"
    printf "Press enter to continue"
    read key
    . $setup_dir/setup.d/_php.sh
fi

echo
echo "Restarting services ..."
echo "mariadb"
instr "MariaDB" "$selection" && ${SUDO} systemctl restart mariadb
echo "nginx"
instr "Nginx" "$selection" && ${SUDO} systemctl restart nginx
echo "php${php_ver}-fpm"
instr "PHP" "$selection" && ${SUDO} systemctl restart php${php_ver}-fpm

echo
echo 'Setup completed!'
echo '----------------'
echo '. ~/.profile to reload bash config.'
echo 'run setup_webutils to install website maintenance utils.'
echo 'run setup_mailhog to install a local mail catcher'
echo 'run setup_samba to install samba'
echo '----------------'
echo
