#!/bin/bash -e
if [ $UID != 65587 ]; then
    echo "You have to run this on Docker" 1>&2
    exit 1
fi

export EDITOR=vim
cd /debuild/build/$BASE_FILES_DIR


echo "SereneLinux ${VERSION} \n \l" > etc/issue
echo "SereneLinux $VERSION" > etc/issue.net
sed -i"" -e s/'DISTRIB_DESCRIPTION=.*'/DISTRIB_DESCRIPTION=\"SereneLinux${VERSION}\"/g etc/lsb-release
sed -i"" -e s/'PRETTY_NAME=.*'/PRETTY_NAME=\"SereneLinux${VERSION}\"/g etc/os-release
sed -i"" -e s!'HOME_URL=.*'!HOME_URL=\"https\:\/\/serenelinux.com\/\"!g etc/os-release
sed -i"" -e s!'SUPPORT_URL=.*'!SUPPORT_URL=\"https:\/\/twitter.com\/SereneDevJP\/\"!g etc/os-release
sed -i"" -e s!'BUG_REPORT_URL=.*'!BUG_REPORT_URL=\"https:\/\/serenelinux.net\/\"!g etc/os-release
cat <<EOF > changelog.new

base-files (${BASE_FILES:11}serene${VERSION:5}) focal; urgency=medium

  * SereneLinux${VERSION}

 -- SereneLinux <serenelinux.dev@gmail.com>  $(date "+%a, %d %b %Y %H:%M:%S +0000")

EOF
cat debian/changelog >> changelog.new
cat changelog.new > debian/changelog
rm changelog.new

debuild -us -uc
cd ..
tar cf ${BASE_FILES}serene${VERSION:5}.tar \
base-files-dbgsym_${BASE_FILES:11}serene${VERSION:5}_amd64.ddeb \
base-files_${BASE_FILES:11}serene${VERSION:5}.dsc \
base-files_${BASE_FILES:11}serene${VERSION:5}_amd64.build \
base-files_${BASE_FILES:11}serene${VERSION:5}_amd64.buildinfo \
base-files_${BASE_FILES:11}serene${VERSION:5}_amd64.changes \
base-files_${BASE_FILES:11}serene${VERSION:5}_amd64.deb \
lsb-release-udeb_${BASE_FILES:11}serene${VERSION:5}_all.udeb
zstd ${BASE_FILES}serene${VERSION:5}.tar
sudo mv *.xz /deb 2>/dev/null
mv *.zst /deb 2>/dev/null
chown -R ${H_UGID} /deb 2>/dev/null
