#!/bin/bash

# enter your prefered version here - default is the latest nightly build
base_url=http://downloads.slimdevices.com/nightly/index.php?ver=7.9

# get latest nightly build url
echo "getting latest version from url: ${base_url}"
latest_nightly=$(curl -s ${base_url} | grep arm.deb | sed -r 's/.*href="\.(.*)".*/\1/')

# download current .deb file into the apt cache
download_url="http://downloads.slimdevices.com/nightly${latest_nightly}"
echo "using download url: ${download_url}"
sudo wget ${download_url}

# get the package name
package_name=$(echo ${latest_nightly} | sed -r 's/.*\/(.*)/\1/')
echo "package name: ${package_name}"

# installing required packages
sudo apt install libio-socket-ssl-perl libnet-ssleay-perl perl-openssl-abi-1.1

# install the downloaded package
sudo dpkg -i ${package_name}

#cleanup
rm -f ./${package_name}
