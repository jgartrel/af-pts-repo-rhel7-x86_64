# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  config.vm.box = "geerlingguy/centos7"
  config.vm.hostname = "vagrant-dev"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  # Execute the folling commands as 'root' user
  config.vm.provision "shell", inline: <<-SHELL
    yum install -y gcc gcc-c++ make autoconf automake glibc-static patch
    yum install -y git
    yum install -y php-cli php-xml bzip2 unzip
  SHELL

  # Execute the folling commands as 'vagrant' user
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    ln -s /vagrant ~/.phoronix-test-suite
    cd ~/.phoronix-test-suite/pts
    ./phoronix-test-suite enterprise-setup
    ./phoronix-test-suite detailed-system-info
    ./phoronix-test-suite install local/af-system
  SHELL

end
