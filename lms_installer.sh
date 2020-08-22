#!/bin/bash

base_url=http://downloads.slimdevices.com/nightly/index.php?ver=7.9
# get latest nightly build url
echo "getting latest version from url: ${base_url}"
latest_nightly=$(curl -s ${base_url} | grep arm.deb | sed -r 's/.*href="\.(.*)".*/\1/')

# update apt cache
# sudo apt update

# download current .deb file into the apt cache
download_url="http://downloads.slimdevices.com/nightly${latest_nightly}"
echo "using download url: ${download_url}"
sudo wget ${download_url}

# run an apt full-upgrade to install the latest package
# sudo apt full-upgrade

# get the package name
package_name=$(echo ${latest_nightly} | sed -r 's/.*\/(.*)/\1/')
echo "package name: ${package_name}"

# install the downloaded package
sudo dpkg -i ${package_name}

#cleanup
rm -f ./${package_name}
