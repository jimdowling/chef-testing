chef-testing
============

To test a cookbook, run:

./vagrant.sh COOKBOOK_NAME

e.g., 
./vagrant.sh ndb

To destroy the VM, run:
./vagrant destroy


If it succeeds, the vagrant machine can be found in:
/tmp/hop

To ssh into the VM, run:
cd /tmp/hop
vagrant ssh
