#!/bin/bash -e
if [ $UID != 0 ]; then
    echo "You have to run this as root." 1>&2
    exit 1
fi
CODENAME=develop
VERSION=$(/home/serene/serene-devtools/getversion.py)
WORKDIR=$(pwd)
BASE_FILES="${WORKDIR}/base-files-10.1ubuntu2.7"

apt-get update && apt-get upgrade -y
cd /home/serene/serene-devtools
echo "SereneLinux ${VERSION} \n \l" > ${BASE_FILES}/etc/issue
echo "SereneLinux $VERSION" > ${BASE_FILES}/etc/issue.net
sed -ie s/'DISTRIB_DESCRIPTION=.*'/DISTRIB_DESCRIPTION=\"SereneLinux${VERSION}\"/g ${BASE_FILES}/etc/lsb-release
sed -ie s/'PRETTY_NAME=.*'/PRETTY_NAME=\"SereneLinux${VERSION}\"/g ${BASE_FILES}/etc/os-release

cd $BASE_FILES
dch -v "${BASE_FILES:11}serene${VERSION:5}"
debuild -us -uc
cd ..
apt-get install -y --allow-downgrades  ./${BASE_FILES}.deb

cd $WORKDIR
apt-get autoremove --purge -y && apt-get clean
rm -rf /var/cache/* \
/var/log/* \
/var/tmp/* \
/var/crash/* \
/var/backups/* \
/root/.bash_history \
/home/serene/.bash_history \
/home/serene/.cache/*

/usr/share/bodhibuilder-gtk/bodhibuilder-gtk.py
