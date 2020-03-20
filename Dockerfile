FROM ubuntu:20.04
ENV VERSION base-files-11ubuntu4
ENV UID 65587
RUN sed -i"" -e 's%http://[^ ]\+%mirror://mirrors.ubuntu.com/mirrors.txt%g' /etc/apt/sources.list \
&& apt-get update \
&& apt-get -y upgrade \
&& apt-get -y install build-essential devscripts zstd gawk libc6 libcrypt1 debhelper dh-systemd apt-utils \
&& rm -rf /tmp/* /var/tmp/* \
&& apt-get clean
RUN useradd -m -u ${UID} docker 
RUN mkdir -p /debuild/build /deb \
ADD ./${VERSION} /debuild/build/${VERSION}
ADD ./debuild.sh /debuild/debuild.sh
RUN chmod +x /debuild/debuild.sh
&& chown -R docker:docker /debuild
USER ${UID}
WORKDIR /debuild
CMD ["./debuild.sh"]