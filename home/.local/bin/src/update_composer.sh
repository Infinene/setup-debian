printf '%s\n'

if [ -f /usr/local/bin/composer ]; then
  printf '%s\n' "Updating composer..."
  ${SUDO} composer selfupdate
else
  printf '%s\n' "composer not installed!!!"
fi
