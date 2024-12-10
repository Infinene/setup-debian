#!/bin/sh
# set -x

if [ "$(whoami)" != "root" ]; then
  SUDO=sudo
fi

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
