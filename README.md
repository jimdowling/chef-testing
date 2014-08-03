chef-testing
============

You can test centos, by running:
cp Vagrantfile.collectd.centos Vagrantfile.collectd

You can test ubuntu, by running:
cp Vagrantfile.collectd.ubuntu Vagrantfile.collectd

To test the system on vagrant, run:

./vagrant.sh 

To kill the VM:
./vagrant destroy


If vagrant succeeds, the VM can be found in:
/tmp/hop

To ssh into the VM, run:
cd /tmp/hop
vagrant ssh
