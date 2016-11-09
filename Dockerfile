FROM ubuntu:trusty
MAINTAINER Manuel Hutter <manuel@hutter.io>

VOLUME /work
WORKDIR /work

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

RUN chmod +x /entrypoint.sh && \
    echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/debbuild && \
    apt-get update && \
    apt-get install -y apt-file build-essential curl debhelper devscripts dput \
        fakeroot gcc gem2deb git git-buildpackage libdistro-info-perl vim && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -c Builder -m -U builder

USER builder
