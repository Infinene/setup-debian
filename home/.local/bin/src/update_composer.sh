printf '%s\n'

if [ -f /usr/local/bin/composer ]; then
  printf '%s\n' "Updating composer..."
  ${SUDO} composer selfupdate
fi
