### php ###
${SUDO} wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | ${SUDO} tee /etc/apt/sources.list.d/php.list

# 'Drupal/CiviCRM requirements'
# 'php-fpm php-apcu php-bcmath php-Curl php-gd php-Intl php-mbstring php-mysql php-soap php-xml php-Zip php-zstd'

${SUDO} apt update
${SUDO} apt -y full-upgrade
${SUDO} apt -y install php${php_ver}-fpm php${php_ver}-apcu php${php_ver}-bcmath php${php_ver}-curl php${php_ver}-gd php${php_ver}-intl php${php_ver}-mbstring php${php_ver}-mysql php${php_ver}-soap php${php_ver}-xml php${php_ver}-zip php${php_ver}-zstd php${php_ver}-redis php${php_ver}-uploadprogress

${SUDO} cp -rbv $setup_dir/etc/php/${php_ver}/* /etc/php/${php_ver}


echo -e "\nInstalling composer ..."
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
${SUDO} php composer-setup.php --filename=composer --install-dir=/usr/local/bin
php -r "unlink('composer-setup.php');"
