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
User=mail
Group=mail

[Install]
WantedBy=multi-user.target
_END_
fi

${SUDO} mkdir -p /var/lib/mailpit
${SUDO} chown mail:mail /var/lib/mailpit

${SUDO} systemctl enable mailpit.service
${SUDO} systemctl start mailpit.service

# Test mail
cat <<EOF | /usr/local/bin/mailpit sendmail -t
To: recipient@example.com
Subject: Testing
From: sender@example.com

This is a test message
EOF

printf "Press enter to continue "
read key
