#!/bin/sh
# set -x

if [ "$(whoami)" != "root" ]; then
  SUDO=sudo
fi

printf "\nInstalling wp-cli ...\n"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
${SUDO} php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

printf "\nInstalling drush ...\n"
# wget https://github.com/drush-ops/drush/releases/download/8.4.12/drush.phar
# mv drush.phar drush
# chmod +x drush
# ${SUDO} mv drush /usr/local/bin
composer global require drush/drush:8.x
${SUDO} ln -s /home/$USER/.config/composer/vendor/bin/drush /usr/local/bin/

printf "\nInstalling cv ...\n"
${SUDO} curl -LsS https://download.civicrm.org/cv/cv.phar -o /usr/local/bin/cv
${SUDO} chmod +x /usr/local/bin/cv

printf "\nInstalling wp-cli ...\n"
${SUDO} curl -LsS https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp
${SUDO} chmod +x /usr/local/bin/wp
wp --info

printf "\nInstalling acme.sh ...\n"
read -p "Enter email for ssl account: " email
curl https://get.acme.sh | sh -s email=$email
$HOME/.acme.sh/acme.sh --set-default-ca --server letsencrypt
