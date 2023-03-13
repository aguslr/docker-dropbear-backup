#!/bin/sh

# Create backup user
if [ "${BACKUP_USER}" ] && ! grep -q -s "^${BACKUP_USER}" /etc/passwd; then
	adduser --shell /bin/sh --uid "${BACKUP_UID:-11000}" --disabled-password "${BACKUP_USER}" && \
	(cd "/home/${BACKUP_USER}" && mkdir -p borgbackup rsync sftp) && \
	chown -R "${BACKUP_USER}":"${BACKUP_USER}" "/home/${BACKUP_USER}/"*
fi

# Start AirSane
/usr/sbin/dropbear "$@"
