#!/bin/sh

# Create backup user
if [ "${BACKUP_USER}" ] && ! grep -s "^${BACKUP_USER}" /etc/passwd; then
	adduser --shell /bin/sh --uid "${BACKUP_UID:-11000}" --disabled-password "${BACKUP_USER}" && \
	mkdir -p "/home/${BACKUP_USER}/"{borgbackup,rsync,sftp} && \
	chown "${BACKUP_USER}":"${BACKUP_USER}" "/home/${BACKUP_USER}/"*
fi

# Start AirSane
/usr/sbin/dropbear "$@"
