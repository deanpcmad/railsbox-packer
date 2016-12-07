Vagrant.configure(2) do |config|
  # Configure The Box
  config.vm.box = 'bento/ubuntu-16.04'
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

  # Configure Port Forwarding
  config.vm.network 'forwarded_port', guest: 3000, host: 3000

  config.vm.synced_folder './', '/vagrant', disabled: true

  # Run The Base Provisioning Script
  config.vm.provision 'shell', path: './scripts/update.sh'
  config.vm.provision :reload
  config.vm.provision 'shell', path: './scripts/provision.sh'
end
