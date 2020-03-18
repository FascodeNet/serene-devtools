#!/bin/bash
set -e
CODENAME=develop
VERSION=$(/home/ksmt/git/serene-devtools/genversion.py)
WORKDIR=$(pwd)
BASE_FILES_DIR="${WORKDIR}/base-files-11ubuntu4"
BASE_FILES=${BASE_FILES_DIR##*/}
H_UID=${UID}
H_GID=${GID}

echo "SereneLinux ${VERSION} \n \l" > ${BASE_FILES_DIR}/etc/issue
echo "SereneLinux $VERSION" > ${BASE_FILES_DIR}/etc/issue.net
sed -i"" -e s/'DISTRIB_DESCRIPTION=.*'/DISTRIB_DESCRIPTION=\"SereneLinux${VERSION}\"/g ${BASE_FILES_DIR}/etc/lsb-release
sed -i"" -e s/'PRETTY_NAME=.*'/PRETTY_NAME=\"SereneLinux${VERSION}\"/g ${BASE_FILES_DIR}/etc/os-release
sed -i"" -e s!'HOME_URL=.*'!HOME_URL=\"https\:\/\/serenelinux.com\/\"!g ${BASE_FILES_DIR}/etc/os-release
sed -i"" -e s!'SUPPORT_URL=.*'!SUPPORT_URL=\"https:\/\/twitter.com\/SereneDevJP\/\"!g ${BASE_FILES_DIR}/etc/os-release
sed -i"" -e s!'BUG_REPORT_URL=.*'!BUG_REPORT_URL=\"https:\/\/serenelinux.net\/\"!g ${BASE_FILES_DIR}/etc/os-release

echo $WORKDIR
sudo docker build -t builddeb ${WORKDIR}
sudo docker run -e VERSION="$VERSION" -e BASE_FILES="$BASE_FILES" -e BASE_FILES_DIR="$BASE_FILES" -e H_UGID="${UID}:$(id -u)" -v ${WORKDIR}/out:/deb -it builddeb /debuild/debuild.sh
