# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.4'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.omnibus.chef_version = :latest

  # Plain precise64 box with kernel upgraded to 3.8 and GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"
  config.vm.define 'cocaine-install'

  config.vm.box = 'ubuntu/trusty64'

  config.vm.network :forwarded_port, guest: 80, host: 48080

  config.berkshelf.enabled = true

  config.vm.provider 'virtualbox' do |v|
    v.memory = 2048
  end

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'apt::default'
    chef.add_recipe 'cocaine::qr'
  end
end
