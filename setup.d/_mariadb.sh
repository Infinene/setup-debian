### mariadb ###

if [ "$(lsb_release -sc)" != "bookworm" ]; then
    echo "deb [arch=amd64,i386,arm64,ppc64el] https://mirror.rackspace.com/mariadb/repo/${mariadb_ver}/debian `lsb_release -cs` main" | ${SUDO} tee /etc/apt/sources.list.d/mariadb.list
    ${SUDO} apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
    ${SUDO} apt update
fi

${SUDO} apt -y install mariadb-server
${SUDO} cp -rbv $setup_dir/etc/mysql/* /etc/mysql/