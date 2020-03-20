#!/bin/bash
set -e
CODENAME=develop
VERSION=$(/home/ksmt/git/serene-devtools/genversion.py)
WORKDIR=$(pwd)
BASE_FILES_DIR="${WORKDIR}/base-files-11ubuntu4"
BASE_FILES=${BASE_FILES_DIR##*/}
H_UID=${UID}
H_GID=${GID}

sudo docker build -t builddeb ${WORKDIR}
sudo docker run -e VERSION="$VERSION" -e BASE_FILES="$BASE_FILES" -e BASE_FILES_DIR="$BASE_FILES" -e H_UGID="${UID}:$(id -u)" -v ${WORKDIR}/out:/deb -it builddeb /debuild/debuild.sh