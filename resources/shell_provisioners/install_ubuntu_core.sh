#!/bin/bash -x

URL=https://github.com/cfengine/core.git

# If /var/cfengine exists, do nothing, assume it's installed already
test -d /var/cfengine && exit 0

cd /var/tmp
apt-get -qq update
apt-get -qq -y install git autoconf libtool libtokyocabinet-dev libpcre3-dev libxml2-dev libvirt-dev libacl1-dev bison flex make libssl-dev libpam-dev

git clone -q https://git.gitorious.org/mdb/mdb.git && cd mdb/libraries/liblmdb && make install
ldconfig

cd /var/tmp

if [ -z "$1" ]; then
    git clone -q --depth 1 $URL ./core
else
    git clone -q --depth 1 --branch $1 $URL ./core
fi

cd /var/tmp/core && ./autogen.sh && make && make install
