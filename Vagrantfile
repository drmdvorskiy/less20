Vagrant.configure("2") do |config|

  config.vm.provision "file", source: "key/id_rsa.pub", destination: "/home/vagrant/.ssh/id_rsa.pub"
  config.vm.provision "shell", inline: <<-SHELL
    cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
  SHELL

  config.vm.define "master" do |master|
    master.vm.box = "ubuntu/focal64"
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "192.168.6.2", hostname: true
    master.vm.synced_folder ".", "/vagrant", disabled: true
    master.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 1
    end
  end

  config.vm.define "minion1" do |minion1|
    minion1.vm.box = "ubuntu/focal64"
    minion1.vm.hostname = "minion1"
    minion1.vm.network "private_network", ip: "192.168.6.3", hostname: true
    minion1.vm.synced_folder ".", "/vagrant", disabled: true
    minion1.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 1
    end
  end

  config.vm.define "minion2" do |minion2|
    minion2.vm.box = "ubuntu/focal64"
    minion2.vm.hostname = "minion2"
    minion2.vm.network "private_network", ip: "192.168.6.4", hostname: true
    minion2.vm.synced_folder ".", "/vagrant", disabled: true
    minion2.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 1
    end
  end

end
