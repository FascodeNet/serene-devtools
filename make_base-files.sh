#!/bin/bash
set -e
CODENAME=develop
VERSION=$(/home/ksmt/git/serene-devtools/genversion.py)
WORKDIR=$(pwd)
BASE_FILES_DIR="${WORKDIR}/base-files-11ubuntu3"
BASE_FILES=${BASE_FILES_DIR##*/}

echo "SereneLinux ${VERSION} \n \l" > ${BASE_FILES_DIR}/etc/issue
echo "SereneLinux $VERSION" > ${BASE_FILES_DIR}/etc/issue.net
sed -i"" -e s/'DISTRIB_DESCRIPTION=.*'/DISTRIB_DESCRIPTION=\"SereneLinux${VERSION}\"/g ${BASE_FILES_DIR}/etc/lsb-release
sed -i"" -e s/'PRETTY_NAME=.*'/PRETTY_NAME=\"SereneLinux${VERSION}\"/g ${BASE_FILES_DIR}/etc/os-release
sed -i"" -e s!'HOME_URL=.*'!HOME_URL=\"https\:\/\/serenelinux.com\/\"!g ${BASE_FILES_DIR}/etc/os-release
sed -i"" -e s!'SUPPORT_URL=.*'!SUPPORT_URL=\"https:\/\/twitter.com\/SereneDevJP\/\"!g ${BASE_FILES_DIR}/etc/os-release
sed -i"" -e s!'BUG_REPORT_URL=.*'!BUG_REPORT_URL=\"https:\/\/serenelinux.net\/\"!g ${BASE_FILES_DIR}/etc/os-release

sudo docker run -it builddeb -v out:/deb -e VERSION=$VERSION -e BASE_FILES=$BASE_FILES
#cd $BASE_FILES_DIR
#dch -v ${BASE_FILES:11}serene${VERSION:5}
#debuild -us -uc
#cd ..
#tar --remove-file -cf ${BASE_FILES}serene${VERSION:5}.tar \
#base-files-dbgsym_${BASE_FILES:11}serene${VERSION:5}_amd64.ddeb \
#base-files_${BASE_FILES:11}serene${VERSION:5}.dsc \
#base-files_${BASE_FILES:11}serene${VERSION:5}.tar \
#base-files_${BASE_FILES:11}serene${VERSION:5}.tar.xz \
#base-files_${BASE_FILES:11}serene${VERSION:5}_amd64.build \
#base-files_${BASE_FILES:11}serene${VERSION:5}_amd64.buildinfo \
#base-files_${BASE_FILES:11}serene${VERSION:5}_amd64.changes \
#base-files_${BASE_FILES:11}serene${VERSION:5}_amd64.deb \
#lsb-release-udeb_${BASE_FILES:11}serene${VERSION:5}_all.udeb
