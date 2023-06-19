### mariadb ###

if [ "$debian_release" != "bookworm" ]; then
    printf "deb [arch=amd64,i386,arm64,ppc64el] https://mirror.rackspace.com/mariadb/repo/${mariadb_ver}/debian $debian_release main\n" | ${SUDO} tee /etc/apt/sources.list.d/mariadb.list
    ${SUDO} apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
    ${SUDO} apt update
fi

${SUDO} apt -y install mariadb-server
${SUDO} cp -rbv $setup_dir/etc/mysql/* /etc/mysql/

printf "\nCreating admin user for phpMyAdmin ...\n"
printf -- "-------------------------------------\n"
printf "Enter a password for '${USER}' for mariadb: "
read_secret dbpass
printf "Granting all privileges to '${USER}' ...\n"
sudo mysql -e "CREATE USER ${USER}@'%' IDENTIFIED BY '${dbpass}'; \
GRANT ALL PRIVILEGES ON *.* TO ${USER}@'%' WITH GRANT OPTION;"
