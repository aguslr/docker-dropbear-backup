[aguslr/docker-dropbear-backup][1]
==================================

[![docker-pulls](https://img.shields.io/docker/pulls/aguslr/dropbear-backup)](https://hub.docker.com/r/aguslr/dropbear-backup) [![image-size](https://img.shields.io/docker/image-size/aguslr/dropbear-backup/latest)](https://hub.docker.com/r/aguslr/dropbear-backup)


This *Docker* image sets up *Dropbear* inside a docker container that allows
remote backups using *Borg*, *rsync* or *sftp-server*

> **[Dropbear][2]** is a relatively small SSH server that runs on a variety of
> unix platforms.

> **[Borg][3]** is a deduplicating backup software for various Unix-like
> operating systems.

> **[rsync][4]** is a utility for efficiently transferring and synchronizing
> files between a computer and a storage drive and across networked computers.

> **[sftp-server][5]** is a program that speaks the server side of SFTP protocol
> to stdout and expects client requests from stdin.


Installation
------------

To use *docker-dropbear-backup*, follow these steps:

1. Clone and start the container:

       docker run -p 2222:22 \
         -e BACKUP_USER=bob \
         -e BACKUP_UID=1000 \
         -v ./dropbear:/etc/dropbear \
         -v ./backups:/home/bob \
         docker.io/aguslr/dropbear-backup:latest

2. Configure your backup software to connect to your *Dropbear* server's IP
   address on port `2222` with user `BACKUP_USER`.


### Variables

The image is configured using environment variables passed at runtime. All these
variables are prefixed by `BACKUP_`.

| Variable | Function                           | Default   | Required |
| :------- | :--------------------------------- | :-------- | -------- |
| `USER`   | New user that will own the backups | `rbackup` | N        |
| `UID`    | UID of the new user                | 11000     | N        |


#### Authorized keys file

To allow certain users to use the server for backup, we can copy the SSH keys
into the `authorized_keys` file (e. g. `./backups/.ssh/authorized_keys`)
with the format:

    no-agent-forwarding,no-port-forwarding,no-pty,no-X11-forwarding SSH_KEY USER@HOST


Build locally
-------------

Instead of pulling the image from a remote repository, you can build it locally:

1. Clone the repository:

       git clone https://github.com/aguslr/docker-dropbear-backup.git

2. Change into the newly created directory and use `docker-compose` to build and
   launch the container:

       cd docker-dropbear-backup && docker-compose up --build -d


[1]: https://github.com/aguslr/docker-dropbear-backup
[2]: https://matt.ucc.asn.au/dropbear/dropbear.html
[3]: https://borgbackup.org/
[4]: https://rsync.samba.org/
[5]: https://man.openbsd.org/sftp-server.8
