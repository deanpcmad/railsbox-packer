# Railsbox

Scripts used for building [railsbox](https://github.com/joshfng/railsbox). If you're looking for just the Vagrant box to run a local Ruby/Rails dev env please see the [railsbox repo](https://github.com/joshfng/railsbox).

You can find the box hosted on Atlas [here](https://atlas.hashicorp.com/joshfng/boxes/railsbox/)

## Ruby 1.9.3

Uses a Ubuntu 16.04 machine & installs Ruby 1.9.3-p511 with MariaDB 10.1

## Ruby 2.2.9

Uses a Ubuntu 16.04 machine & installs Ruby 2.2.9 with MariaDB 10.1

## Ruby 2.3.8

Uses a Ubuntu 16.04 machine & installs Ruby 2.3.8 with MariaDB 10.1

# Ruby 2.7

Uses a Ubuntu 18.04 machine and installs Ruby 2.7.0 with MariaDB 10.4

## Development

All the work is done in `scripts/provision.sh`, modify it to suite your needs.

```shell
./build.sh ruby_27
```

This will build the vagrant box available as `virtualbox.box`

## Vagrantfile

```ruby
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'
Vagrant.require_version '>= 1.5'

Vagrant.configure('2') do |config|
  name = File.basename(Dir.getwd) + '-dev'

  # change this to ruby_22, ruby_23 or ruby_27
  config.vm.box = 'deanpcmad/ruby_27'
  
  config.ssh.forward_agent = true
  config.vm.hostname = name

  config.vm.synced_folder '.', '/vagrant'

  config.vm.provider :virtualbox do |v|
    v.name = name
    v.memory = 2048
    v.cpus = 4
    v.customize [
      'modifyvm', :id,
      '--nictype1', 'virtio',
      '--name', name,
      '--natdnshostresolver1', 'on'
    ]
  end

  # rails
  config.vm.network 'forwarded_port', guest: 3000, host: 3000
end
```