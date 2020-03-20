FROM ubuntu:20.04
ARG VERSION="base-files-11ubuntu4"
ARG UID=65587
RUN sed -i"" -e 's%http://[^ ]\+%mirror://mirrors.ubuntu.com/mirrors.txt%g' /etc/apt/sources.list \
&& apt-get update \
&& apt-get -y upgrade \
&& apt-get install -y --no-install-recommends build-essential devscripts zstd gawk libc6 libcrypt1 debhelper dh-systemd apt-utils sudo \
&& rm -rf /tmp/* /var/tmp/* \
&& apt-get clean
RUN echo "root:root" | chpasswd && \
    adduser --disabled-password --uid ${UID} --gecos "" docker && \
    echo "docker:docker" | chpasswd && \
    echo "%docker    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/docker && \
    chmod 0440 /etc/sudoers.d/docker
RUN mkdir -p /debuild/build /deb 
ADD ./${VERSION} /debuild/build/${VERSION}
ADD ./debuild.sh /debuild/debuild.sh
RUN chmod +x /debuild/debuild.sh \
&& chown -R docker:docker /debuild
USER ${UID}
WORKDIR /debuild
CMD ["./debuild.sh"]