FROM debian:experimental
RUN apt-get update && apt-get -y install devscripts pbuilder git-core aptitude
WORKDIR /tmp
RUN git clone https://github.com/Debian/debile
WORKDIR /tmp/debile
RUN /usr/lib/pbuilder/pbuilder-satisfydepends
RUN dpkg-buildpackage
WORKDIR /tmp
RUN dpkg --force-depends -i *.deb && apt-get -fy install
RUN mkdir -p /srv/debile/incoming/UploadQueue \
             /srv/debile/files/default \
             /srv/debile/repo/default
RUN chown -R Debian-debile:Debian-debile /srv/debile/
RUN chmod 0773 /srv/debile/incoming/UploadQueue
COPY setup.sh /opt/setup.sh
USER Debian-debile
RUN /opt/setup.sh
USER root
ENTRYPOINT /usr/bin/debile-master
