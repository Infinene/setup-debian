### mariadb ###

if [ "$debian_release" != "bookworm" ]; then
    printf "deb [arch=amd64,i386,arm64,ppc64el] https://mirror.rackspace.com/mariadb/repo/${mariadb_ver}/debian $debian_release main\n" | ${SUDO} tee /etc/apt/sources.list.d/mariadb.list
    ${SUDO} apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
    ${SUDO} apt update
fi

${SUDO} apt -y install mariadb-server
${SUDO} cp -rbv $setup_dir/etc/mysql/* /etc/mysql/

dbpass=$(whiptail --passwordbox "Enter a password for user '${USER}' as admin for MariaDB: " 8 0 --title "Create MariaDB admin account"  3>&1 1>&2 2>&3)
exitstatus=$?
if [ "x$dbpass" != "x" ]; then
    echo "Creating MariaDB user $USER and Granting all privileges to this account ..."
    ${SUDO} mysql -e "CREATE USER ${USER}@'%' IDENTIFIED BY '${dbpass}'; \
    GRANT ALL PRIVILEGES ON *.* TO ${USER}@'%' WITH GRANT OPTION;"
else
    echo "User account not created: canceled or no password entered"
fi
