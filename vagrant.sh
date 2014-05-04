#!/bin/bash

set -e

if [ $# -ne 1 ] ; then
 echo "usage: $0 cookbook"
 echo "usage: $0 destroy"
 exit 1
fi
if [ "$1" == "destroy" ] ; then
  cd /tmp/hop
  vagrant destroy
  exit 0
fi

cookbook=$1

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
berks vendor /tmp/hop/cookbooks
popd
cp Vagrantfile.${cookbook} /tmp/hop/Vagrantfile
cd /tmp/hop
vagrant up
exit 0
