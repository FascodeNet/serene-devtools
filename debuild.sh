#!/bin/bash -e
if [ $UID != 0 ]; then
    echo "You have to run this on Docker" 1>&2
    exit 1
fi

export EDITOR=vim
cd /debuild/build/$BASE_FILES_DIR

cat <<EOF > changelog.new

base-files (${BASE_FILES:11}serene${VERSION:5}) bionic; urgency=medium

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
mv *.xz /deb
mv *.zst /deb
chown -R ${H_UGID} /deb
