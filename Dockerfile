FROM ubuntu:20.04
RUN sed -i"" -e 's%http://[^ ]\+%mirror://mirrors.ubuntu.com/mirrors.txt%g' /etc/apt/sources.list \
&& apt-get update \
&& apt-get -y upgrade \
&& apt-get -y install \
automake autopoint autotools-dev binutils binutils-common binutils-x86-64-linux-gnu build-essential cpp cpp-9 debhelper dh-autoreconf dh-strip-nondeterminism dh-systemd dpkg-dev dwz g++ g++-9 gcc \
autoconf gcc-9 gettext intltool-debian libarchive-zip-perl libasan5 libatomic1 libbinutils libc-dev-bin libc6-dev libcc1-0 libcroco3 libcrypt-dev libctf-nobfd0 libctf0 libdebhelper-perl libdpkg-perl \
libelf1 libfile-stripnondeterminism-perl libgcc-9-dev libgomp1 libisl22 libitm1 liblsan0 libmpc3 libmpfr6 libquadmath0 libsigsegv2 libstdc++-9-dev libsub-override-perl libtool libtsan0 libubsan1 \
linux-libc-dev m4 po-debconf zstd

RUN mkdir -p /debuild/build /deb
ADD ./base-files-11ubuntu3 /debuild/build
RUN chown -R root:root /debuild
WORKDIR /debuild
CMD cd build; dch -v ${BASE_FILES:11}serene${VERSION:5}; debuild -us -uc; cd ..; tar --remove-file -cf ${BASE_FILES}serene${VERSION:5}.tar \
base-files-dbgsym_${BASE_FILES:11}serene${VERSION:5}_amd64.ddeb \
base-files_${BASE_FILES:11}serene${VERSION:5}.dsc \
base-files_${BASE_FILES:11}serene${VERSION:5}.tar \
base-files_${BASE_FILES:11}serene${VERSION:5}.tar.xz \
base-files_${BASE_FILES:11}serene${VERSION:5}_amd64.build \
base-files_${BASE_FILES:11}serene${VERSION:5}_amd64.buildinfo \
base-files_${BASE_FILES:11}serene${VERSION:5}_amd64.changes \
base-files_${BASE_FILES:11}serene${VERSION:5}_amd64.deb \
lsb-release-udeb_${BASE_FILES:11}serene${VERSION:5}_all.udeb; mv *.zst /deb
