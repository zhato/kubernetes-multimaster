# -*- mode: ruby -*-
# vi: set ft=ruby :

require './vagrant-provision-reboot-plugin'

load 'config.rb'

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.synced_folder ".", "/shared"

  ## MASTER
  (1..$master_count).each do |i|
    masterIp = $clusterIp+"#{i+30}"
    config.vm.define vm_name = "master-%d" % i do |master|
      master.vm.network :private_network, :ip => "#{masterIp}"
      master.vm.hostname = vm_name
      master.vm.provider "virtualbox" do |v|
        v.memory = $master_memory
      end
      # Instal Kubrntes
      master.vm.provision :shell, :inline => "sh /shared/common.sh"
      # Reboot
      master.vm.provision :unix_reboot
    end
  end

  ## NODE
  (1..$node_count).each do |i|
    config.vm.define vm_name = "node-%d" % i do |node|
      nodeIp = $clusterIp+"#{i+40}"
      node.vm.network :private_network, :ip => "#{nodeIp}"
      node.vm.hostname = vm_name
      node.vm.provider "virtualbox" do |v|
        v.memory = $node_memory
      end
      # Instal Kubrntes
      node.vm.provision :shell, :inline => "sh /shared/common.sh"
      # Reboot
      node.vm.provision :unix_reboot
    end
  end
end
