 # | |  | |/ __ \|  __ \ 
 # | |__| | |  | | |__) |
 # |  __  | |  | |  ___/ 
 # | |  | | |__| | |     
 # |_|  |_|\____/|_|  

#Vagrant.require_plugin "vagrant-berkshelf"

Vagrant::Config.run do |config|
  # Berkshelf plugin configuration
#  config.berkshelf.enabled = true 

 config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
# config.vm.box = "raring64server"
# config.vm.box_url = "http://goo.gl/Y4aRr"

 config.vm.customize ["modifyvm", :id, "--memory", 6800]
 config.vm.customize ["modifyvm", :id, "--cpus", "1"]
 config.vm.network :bridged
# Mysql server port
  config.vm.forward_port 22, 9090
  config.vm.forward_port 3306, 4306
# Glassfish webserver admin console port
  config.vm.forward_port 4848, 5858
# Hop admin console (secure)
  config.vm.forward_port 8181, 9191

 # Ubuntu 12.04 Config
  # config.vm.define :ubuntu1204 do |ubuntu1204|
  #   ubuntu1204.vm.hostname = "ubuntu1204"
  #   ubuntu1204.vm.box = "opscode-ubuntu-12.04"
  #   ubuntu1204.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box"
  #   ubuntu1204.vm.provision :chef_client do |chef|
  #     chef.environment = chef_environment
  #     chef.run_list = chef_run_list.unshift("recipe[apt::cacher-client]")
  #   end
  # end

# Centos 6.4 Config
  # config.vm.define :centos64 do |centos64|
  #   centos64.vm.hostname = "centos64"
  #   centos64.vm.box = "opscode-centos-6.4"
  #   centos64.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_centos-6.4_provisionerless.box"
  #   centos64.vm.provision :chef_client do |chef|
  #     chef.environment = chef_environment
  #     chef.run_list = chef_run_list
  #   end
  # end

   config.vm.provision :chef_solo, :log_level => :debug do |chef|
     chef.log_level = :debug
     chef.cookbooks_path = "cookbooks"
     chef.json = {
     "btsync" =>	{
     		 "bootstrap" => "true",
                 "ndb" =>      { 
	  	       "leechers" => ["10.0.2.15"],
	  	       "seeder_secret" => "AY27AAZKTKO3GONE6PBCZZRA6MKGRKBX2",
	  	       "leecher_secret" => "BTHKJKK4PIPIOJZ7GITF2SJ2IYDLSSJVY",
	       },
          },
     "mysql" => {
                    "server_root_password" => "kthfs"
          },
     "ndb" => {
          "enabled" => "true",
          "mgmd" => { 
     	  	       "private_ips" => ["10.0.2.15"]
	       },
	  "ndbd" =>      { 
   	  	       "private_ips" => ["10.0.2.15"]
	       },
	  "mysqld" =>      { 
   	  	       "private_ips" => ["10.0.2.15"]
	       },
	  "memcached" =>      { 
   	  	       "private_ips" => ["10.0.2.15"]
	       },
          "ndbapi" =>    { 
       	  	      "private_ips" => ["10.0.2.15"]
               },
          "data_memory" => "48",
          "public_ips" => ["10.0.2.15"],
          "private_ips" => ["10.0.2.15"],
     },
     "dashboard" => {
	  "public_ips" => ["10.0.2.15"],
  	  "private_ips" => ["10.0.2.15"],
     },
     "public_ips" => ["10.0.2.15"],
     "private_ips" => ["10.0.2.15"],
     "collectd"  =>    {
# DN - jmx metrics disabled for hdfs 2.2. Now available at REST api http://localhost:50075/jmx via JSON
     		 "clients" => ["mysqld","nn", "rm", "nm"],
     		 "private_ips" => "[10.0.2.15]",
     		 "public_ips" => "[10.0.2.15]"
         },
     "hopagent"  =>    {
                 "agent_user" => "hopagent@sics.se",
                 "agent_password" => "hopagent"
         },

     "hop"  =>    {
     	         "cluster" => "vagrant",
                 "hostid" => "10",
		 "rm" =>    { 
       	  	      "private_ips" => ["10.0.2.15"]
                 },
		 "nn" =>    { 
       	  	      "private_ips" => ["10.0.2.15"]
                 },
		 "dn" =>    { 
       	  	      "private_ips" => ["10.0.2.15"]
                 },
		 "nm" =>    { 
       	  	      "private_ips" => ["10.0.2.15"]
                 },
		 "historyserver" =>    { 
       	  	      "private_ips" => ["10.0.2.15"]
                 },
          },
     }

      chef.add_recipe "java"
      chef.add_recipe "openssh"
      chef.add_recipe "openssl"

      chef.add_recipe "python"
      chef.add_recipe "hopagent"
      
      chef.add_recipe "collectd::server"

      chef.add_recipe "ndb::btsync"
      chef.add_recipe "ndb::install"
      chef.add_recipe "ndb::mgmd"
      chef.add_recipe "ndb::ndbd"
      chef.add_recipe "ndb::mysqld"
      chef.add_recipe "ndb::mysqld-ndb"
      chef.add_recipe "ndb::memcached"

       chef.add_recipe "collectd::mysqld"
       chef.add_recipe "collectd::nn"
       chef.add_recipe "collectd::rm"
       chef.add_recipe "collectd::nm"

      chef.add_recipe "ndb::mgmd-hop"
      chef.add_recipe "ndb::ndbd-hop"
      chef.add_recipe "ndb::mysqld-hop"
      chef.add_recipe "ndb::memcached-hop"

      chef.add_recipe "glassfish::populate-dbs"
      chef.add_recipe "glassfish::kthfs"
      chef.add_recipe "glassfish::populate-dbs-vagrant"

      chef.add_recipe "hop::nn"
      chef.add_recipe "hop::dn"
      chef.add_recipe "hop::rm"
      chef.add_recipe "hop::nm"
      chef.add_recipe "hop::historyserver"
      #chef.add_recipe "hop::proxyserver"

      #chef.add_recipe "spark"
      #chef.add_recipe "stratosphere"

  end 

end
