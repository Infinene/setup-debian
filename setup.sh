#!/bin/bash
# set -x

echo
echo '               Debian Web Server Setup                     '
echo '               -----------------------                     '
echo '  This will setup basic shell environment and install php  '
echo '  MariaDB and nginx to create a web server.                '

userid=$(id -u)
mariadb_ver='10.11'
php_ver='8.2'

if [[ $userid -eq 0 ]]; then
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

is_wsl=$(grep -i microsoft /proc/version)
setup_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

. $setup_dir/misc/multiselect
. $setup_dir/misc/read_secret

echo
echo "Select / unselect options to install:"
echo '-------------------------------------'


menu=("Shell setup" "MariaDB ${mariadb_ver}" "NginX (mainline)" "PHP ${php_ver}" )
default_selections=("true" "true" "true" "true")
nothing=("false" "false" "false" "false")
multiselect selections menu default_selections

if [[ ! "${selections[*]}" =~ "true" ]]; then
    echo "Nothing selected!"
    exit
fi

if [ ${selections[0]} = "true" ]; then
    echo
    echo "Continue with shell setup ..."
    printf "Press enter to continue"
    ready key
    . $setup_dir/setup.d/_shell.sh
fi

if [ ${selections[1]} = "true" ]; then
    echo
    echo "Continue with installing MariaDB ${mariadb_ver} ..."
    printf "Press enter to continue"
    ready key
    . $setup_dir/setup.d/_mariadb.sh
fi

if [ ${selections[2]} = "true" ]; then
    echo
    echo "Continue with installing Nginx"
    printf "Press enter to continue"
    read key
    . $setup_dir/setup.d/_nginx.sh
fi

if [ ${selections[3]} = "true" ]; then
    echo
    echo "Continue with installing PHP ${php_ver}"
    printf "Press enter to continue"
    read key
    . $setup_dir/setup.d/_php.sh
fi

echo
echo "Restarting services ..."
[ ${selections[1]} = true ] && ${SUDO} systemctl restart mariadb
[ ${selections[2]} = true ] && ${SUDO} systemctl restart nginx
[ ${selections[3]} = true ] && ${SUDO} systemctl restart php${php_ver}-fpm

echo
echo 'Setup completed!'
echo '----------------'
echo '. ~/.profile to reload bash config.'
echo 'run setup_webutils to install website maintenance utils.'
echo 'run setup_mailhog to install a local mail catcher'
echo 'run setup_samba to install samba'
echo 'run setup_lego to install letsencrypt client'
echo '----------------'
echo
