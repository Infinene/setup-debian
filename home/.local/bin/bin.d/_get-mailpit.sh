printf '%s\n'
printf '%s\n' "Updating mailpit..."

repo="axllent/mailpit"

${SUDO} eget --to=/usr/local/bin --upgrade-only $repo

if [ ! -f /etc/systemd/system/mailpit.service ]; then

  ${SUDO} tee /etc/systemd/system/mailpit.service <<_END_
[Unit]
Description=Mailpit server

[Service]
ExecStart=/usr/local/bin/mailpit -d /var/lib/mailpit/mailpit.db
Restart=always
# Restart service after 10 seconds service crashes
RestartSec=10
SyslogIdentifier=mailpit
User=mailpit
Group=mailpit

[Install]
WantedBy=multi-user.target
_END_

  ${SUDO} systemctl enable mailpit.service
  ${SUDO} systemctl enable mailpit.service
fi

printf "Press enter to continue "
read key
