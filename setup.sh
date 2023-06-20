#!/bin/bash
# set -x

printf '%s\n'
printf '%s\n' '               Debian Web Server Setup                     '
printf '%s\n' '               -----------------------                     '
printf '%s\n' '  This will setup basic shell environment and install php  '
printf '%s\n' '  MariaDB and nginx to create a web server.                '

userid=$(id -u)
mariadb_ver='10.11'
php_ver='8.2'

if [[ $userid -eq 0 ]]; then
    tput setaf 1;
    printf '%s\n' "\nRunning as root! User environment and utilities will not be setup."
    tput init
    printf '%s\n' "Launch as a user in sudo group for complete setup."
    while true
    do
        read -p "Continue as root user (y/n)? " choice
        case "$choice" in
        y|Y )   break;;
        n|N )   exit
                break;;
        * )     printf '%s\n' "please enter y/Y or n/N"
                ;;
        esac
    done
else
    SUDO=sudo
    ${SUDO} printf '%s\n' 
fi

is_wsl=$(grep -i microsoft /proc/version)
setup_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

. $setup_dir/misc/multiselect
. $setup_dir/misc/read_secret

printf '%s\n'
printf '%s\n' "Select / unselect options to install:"
printf '%s\n' '-------------------------------------'


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
    echo "Configuring system (shell utils etc.)"
    . $setup_dir/setup.d/_shell.sh
fi

if [ ${selections[1]} = "true" ]; then
    echo
    echo "Installing and configuring MariaDB ${mariadb_ver}"
    read -p "Press enter to continue"
    . $setup_dir/setup.d/_mariadb.sh
fi

if [ ${selections[2]} = "true" ]; then
    echo
    echo "Installing and configuring latest NginX"
    read -p "Press enter to continue"
    . $setup_dir/setup.d/_nginx.sh
fi

if [ ${selections[3]} = "true" ]; then
    echo
    echo "Installing and configuring PHP ${php_ver}"
    read -p "Press enter to continue"
    . $setup_dir/setup.d/_php.sh
fi

echo
echo "Restarting services ..."
[ ${selections[1]} = true ] && ${SUDO} systemctl restart mariadb
[ ${selections[2]} = true ] && ${SUDO} systemctl restart nginx
[ ${selections[3]} = true ] && ${SUDO} systemctl restart php${php_ver}-fpm

printf '%s\n'
printf '%s\n' 'Setup completed!'
printf '%s\n' '----------------'
printf '%s\n' '. ~/.profile to reload bash config.'
printf '%s\n' 'run setup_webutils to install website maintenance utils.'
printf '%s\n' 'run setup_mailhog to install a local mail catcher'
printf '%s\n' 'run setup_samba to install samba'
printf '%s\n' 'run setup_lego to install letsencrypt client'
# if [ ${selections[1]} = "true" ]; then
#     printf '%s\n'
#     printf '%s\n' 'Consider adding mysql superuser for web based administration:'
#     printf '%s\n' "sudo mysql -e \"CREATE USER ${USER}@'%' IDENTIFIED BY 'passwd'; \\" 
#     printf '%s\n' "GRANT ALL PRIVILEGES ON *.* TO ${USER}@'%' WITH GRANT OPTION;\""
# fi
printf '%s\n' '----------------'
printf '%s\n'
