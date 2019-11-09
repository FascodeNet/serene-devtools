#!/bin/bash -e
if [ $UID != 0 ]; then
    echo "You have to run this as root." 1>&2
    exit 1
fi
CODENAME=develop
VERSION=$(/home/serene/serene-devtools/getversion.py)

apt-get update && apt-get upgrade -y
cd /home/serene/serene-devtools
echo "SereneLinux ${VERSION} \n \l" > base-files/etc/issue
echo "SereneLinux $VERSION" > base-files/etc/issue.net
sed -ie s/'DISTRIB_DESCRIPTION=.*'/DISTRIB_DESCRIPTION=\"SereneLinux${VERSION}\"/g base-files/etc/lsb-release
sed -ie s/'VERSION=.*'/VERSION=\"${VERSION: -5} \(${CODENAME}\)\"/g base-files/etc/os-release
sed -ie s/'PRETTY_NAME=.*'/PRETTY_NAME=\"SereneLinux${VERSION}\"/g base-files/etc/os-release
sed -ie s/'VERSION_ID=.*'/VERSION_ID=\"${VERSION: -5}\"/g base-files/etc/os-release
sed -ie s/'VERSION_CODENAME=.*'/VERSION_CODENAME=\"${CODENAME}\"/g base-files/etc/os-release
sed -ie s/'Version=.*'/Version=${VERSION: -5}/g base-files/etc/xdg/kcm-about-distrorc
sed -ie s/'Variant=.*'/"Variant=${CODENAME} Release"/g base-files/etc/xdg/kcm-about-distrorc
sed -ie s/'+serenelinux.*'/+serenelinux${VERSION}/g base-files/DEBIAN/control

dpkg -b base-files
apt-get install -fy  ./base-files.deb

apt-get autoremove --purge -y && apt-get clean
rm -rf /var/cache/* \
/var/log/* \
/var/crash/* \
/var/backups/* \
/tmp/* \
/root/.bash_history \
/home/serene/.bash_history \
/home/serene/.cache/*
bodhibuilder-gtk
