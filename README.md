# Railsbox - Ruby1.9 & Ruby2.7

Scripts used for building [railsbox](https://github.com/joshfng/railsbox). If you're looking for just the Vagrant box to run a local Ruby/Rails dev env please see the [railsbox repo](https://github.com/joshfng/railsbox).

You can find the box hosted on Atlas [here](https://atlas.hashicorp.com/joshfng/boxes/railsbox/)

## Ruby1.9

Uses a Ubuntu 16.04 machine & installs Ruby 1.9.3-p511 with MariaDB 10.1

# Ruby2.7

Uses a Ubuntu 18.04 machine and installs Ruby 2.7.0 with MariaDB 10.4

## Development
All the work is done in `scripts/provision.sh`, modify it to suite your needs.

```shell
./build.sh
```

This will build the vagrant box available as `virtualbox.box`

## License

MIT

## Credit

Josh Frye @joshfng on GitHub and Twitter
