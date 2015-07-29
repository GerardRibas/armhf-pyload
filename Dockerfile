FROM armv7/armhf-archlinux
MAINTAINER Gerard Ribas <gerard.ribas.canals@gmail.com>

ENV PACMAN_PACKAGES python2 python2-pycurl python2-crypto unzip wget
ENV PYLOAD_VERSION v0.4.9

RUN pacman -Sy --needed ${PACMAN_PACKAGES} --noconfirm

ENV RUN_USER   daemon
ENV RUN_GROUP  daemon

RUN chown -R ${RUN_USER}:${RUN_GROUP} /usr/bin/python2 \
    && chmod +x /usr/bin/python2                       \
    && yes|pacman -Scc                                 \
    && rm -rf /usr/share/locale/*                      \
    && rm -rf /usr/share/man/*                         \
    && rm -rf /tmp/*

RUN wget https://github.com/pyload/pyload/releases/download/${PYLOAD_VERSION}/pyload-src-${PYLOAD_VERSION}.zip \
	&& unzip pyload-src-${PYLOAD_VERSION}.zip -d /opt/                                                         \
	&& rm pyload-src-${PYLOAD_VERSION}.zip                                                                     \
	&& chown -R ${RUN_USER}:${RUN_GROUP} /opt/pyload

VOLUME /config
VOLUME /downloads

#Remote Port
EXPOSE 7227

#Web Interface
EXPOSE 8001

USER ${RUN_USER}:${RUN_GROUP}

CMD ["/usr/bin/python2", "/opt/pyload/pyLoadCore.py","--configdir=/config"]
