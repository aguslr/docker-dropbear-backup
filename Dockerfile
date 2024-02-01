ARG BASE_IMAGE=library/debian:stable-slim

FROM docker.io/${BASE_IMAGE}

RUN \
  apt-get update && \
  env DEBIAN_FRONTEND=noninteractive \
  apt-get install -y --no-install-recommends dropbear-bin borgbackup openssh-sftp-server rsync \
  -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
COPY bin/ssh_command.sh /usr/local/bin

EXPOSE 22/tcp

VOLUME /etc/dropbear

HEALTHCHECK --interval=1m --timeout=3s \
  CMD timeout 2 nc 127.0.0.1 22 | grep -qE "^SSH.*dropbear"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["-RFEmwsgk", "-p", "22", "-c", "/usr/local/bin/ssh_command.sh"]
