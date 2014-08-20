#!/bin/bash

set -e

if [ "$1" == "destroy" ] ; then
  cd /tmp/hop
  vagrant destroy
  exit 0
fi
if [ "$1" == "ssh" ] ; then
  cd /tmp/hop
  vagrant ssh
  exit 0
elif [ $# -gt 0 ] ; then
  echo "Usage: <prog> [destroy|ssh]"
  exit 2
fi

echo "****************"
echo "Your Vagrant VM will be run from:"
echo "/tmp/hop"
echo "****************"
cookbook=collectd

pushd .


dest=/tmp/${cookbook}-chef

rm -rf $dest
cd /tmp
git clone https://github.com/hopstart/$cookbook-chef.git
if [ ! -d $dest ] ; then
 echo "Couldn't find repo: https://github.com/hopstart/$cookbook-chef.git"
 exit 2
fi
cd $dest
rm -rf /tmp/hop
mkdir -p /tmp/hop
rm -rf Berksfile.lock
berks vendor /tmp/hop/cookbooks
popd
pushd .
cd ../hopdashboard-chef
rm -rf Berksfile.lock
rm -rf /tmp/dashy
berks vendor /tmp/dashy
cd ../hop-chef
rm -rf /tmp/hopsy
rm -rf Berksfile.lock
berks vendor /tmp/hopsy
cp -rf /tmp/dashy/* /tmp/hop/cookbooks/
cp -rf /tmp/hopsy/* /tmp/hop/cookbooks/
popd
cp Vagrantfile.${cookbook} /tmp/hop/Vagrantfile
cd /tmp/hop
vagrant up
exit 0
