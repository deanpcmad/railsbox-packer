Vagrant.configure(2) do |config|
  # Configure The Box
  config.vm.box = 'bento/ubuntu-18.04'
  config.vm.hostname = 'railsbox'

  # Don't Replace The Default Key https://github.com/mitchellh/vagrant/pull/4707
  config.ssh.insert_key = false

  config.vm.provider :virtualbox do |v|
    v.name = config.vm.hostname
    v.memory = 4096
    v.cpus = 4
    v.customize [
      'modifyvm', :id,
      '--nictype1', 'virtio',
      '--name', config.vm.hostname,
      '--natdnshostresolver1', 'on'
    ]
  end

  config.vm.synced_folder './', '/vagrant', disabled: true

  # Run The Base Provisioning Script
  config.vm.provision 'shell', path: './scripts/update.sh'
  config.vm.provision :reload
  config.vm.provision 'shell', path: './scripts/provision.sh'
  config.vm.provision 'shell', path: './scripts/browsers.sh'
  config.vm.provision 'shell', path: './scripts/cleanup.sh'
end
