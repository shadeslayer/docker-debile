FROM debian:experimental
RUN apt-get update && apt-get -y install devscripts pbuilder git-core aptitude
WORKDIR /tmp
RUN git clone https://github.com/Debian/debile
WORKDIR /tmp/debile
RUN /usr/lib/pbuilder/pbuilder-satisfydepends
RUN dpkg-buildpackage
WORKDIR /tmp
RUN dpkg --force-depends -i *.deb && apt-get -fy install
COPY setup.sh /opt/debile/
COPY run.sh /opt/debile/
COPY config.yaml /opt/debile/
EXPOSE 22017
ENTRYPOINT /opt/debile/run.sh
