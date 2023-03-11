#!/bin/sh

# Wrapper for $SSH_ORIGINAL_COMMAND

# Get binary
SSH_COMMAND_BIN="${SSH_ORIGINAL_COMMAND%% *}"

case "${SSH_COMMAND_BIN}" in
	*borg)
		/usr/bin/borg serve --append-only --restrict-to-path ~/borgbackup/
		;;
	*rsync)
		/usr/bin/rrsync ~/rsync/
		;;
	*sftp-server)
		/usr/lib/ssh/sftp-server -d ~/sftp/
		;;
	*)
		printf "Access denied\n" >&2
		exit 1
		;;
esac
