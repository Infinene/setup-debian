#!/bin/bash
# set -x

if [ "$(whoami)" != "root" ]; then
  SUDO=sudo
fi

printf '%s\n' '\nInstalling drush ...'
wget https://github.com/drush-ops/drush/releases/download/8.4.12/drush.phar
mv drush.phar drush
chmod +x drush
${SUDO} mv drush /usr/local/bin

printf '%s\n' '\nInstalling cv ...'
${SUDO} curl -LsS https://download.civicrm.org/cv/cv.phar -o /usr/local/bin/cv
${SUDO} chmod +x /usr/local/bin/cv

printf '%s\n' '\nInstalling wp-cli ...'
${SUDO} curl -LsS https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp
${SUDO} chmod +x /usr/local/bin/wp
wp --info
