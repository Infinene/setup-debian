echo

if [ -f /usr/local/bin/composer ]; then
  echo "Updating composer..."
  ${SUDO} composer selfupdate
fi
