#!/bin/bash

set -e

if [ $# -eq 1 ] ; then
if [ "$1" == "destroy" ] ; then
  cd /tmp/hop
  vagrant destroy
  exit 0
else 
  echo "invalid parameter"
fi
  exit 0
fi

echo "****************"
echo "Your Vagrant VM will be run from:"
echo "/tmp/hop"
echo "****************"
cookbook=caracaldb

pushd .


dest=/tmp/${cookbook}-chef

rm -rf $dest
cd /tmp
git clone https://github.com/caracaldb/$cookbook-chef.git
if [ ! -d $dest ] ; then
 echo "Couldn't find repo: https://github.com/caracaldb/$cookbook-chef.git"
 exit 2
fi
cd $dest
rm -rf /tmp/hop
mkdir -p /tmp/hop
berks vendor /tmp/hop/cookbooks
popd
cp Vagrantfile.${cookbook} /tmp/hop/Vagrantfile
cd /tmp/hop
vagrant up
exit 0
