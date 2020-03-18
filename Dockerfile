FROM ubuntu:18.04
ENV VERSION base-files-10.1ubuntu2.8
RUN sed -i"" -e 's%http://[^ ]\+%mirror://mirrors.ubuntu.com/mirrors.txt%g' /etc/apt/sources.list \
&& apt-get update \
&& apt-get -y upgrade \
&& apt-get -y install build-essential devscripts zstd gawk libc6 libcrypt1 vim debhelper dh-systemd apt-utils
RUN mkdir -p /debuild/build /deb
ADD ./${ENV} /debuild/build/${ENV}
ADD ./debuild.sh /debuild/debuild.sh
RUN chown -R root:root /debuild \
&& chmod +x /debuild/debuild.sh
RUN rm -rf /tmp/* /var/tmp/* \
&& apt-get clean
WORKDIR /debuild
VOlUME out
CMD ["./debuild.sh"]
