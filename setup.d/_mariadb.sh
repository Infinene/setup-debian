### mariadb ###
set -x
${SUDO} apt-get install apt-transport-https curl
${SUDO} mkdir -p /etc/apt/keyrings
${SUDO} curl -o /etc/apt/keyrings/mariadb-keyring.pgp 'https://mariadb.org/mariadb_release_signing_key.pgp'

${SUDO} tee /etc/apt/sources.list.d/mariadb.lst <<EOL
# MariaDB 11.4 repository list - created 2024-10-02 07:52 UTC
# https://mariadb.org/download/
X-Repolib-Name: MariaDB
Types: deb
# deb.mariadb.org is a dynamic mirror if your preferred mirror goes offline. See https://mariadb.org/mirrorbits/ for details.
# URIs: https://deb.mariadb.org/${mariadb_ver}/debian
URIs: https://mirror.rackspace.com/mariadb/repo/${mariadb_ver}/debian
Suites: bookworm
Components: main
Signed-By: /etc/apt/keyrings/mariadb-keyring.pgp
EOL

${SUDO} apt update
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
