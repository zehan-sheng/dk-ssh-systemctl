FROM debian

LABEL maintainer="Debian-sshwithsystemctl"
LABEL build_date="2023-09-01"

ENV container docker
ENV DEBIAN_FRONTEND noninteractive

# Enable systemd.
RUN apt-get update && \
    apt-get install -y systemd systemd-sysv openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    # ... 其他清理操作

VOLUME [ "/sys/fs/cgroup" ]

RUN sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    passwd root -u root -p root

CMD ["/usr/sbin/sshd"]
