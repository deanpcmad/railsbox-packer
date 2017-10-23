# Railsbox Packer

Scripts used for building [railsbox](https://github.com/joshfng/railsbox). If you're looking for just the Vagrant box to run a local Ruby/Rails dev env please see the [railsbox repo](https://github.com/joshfng/railsbox).

You can find the box hosted on Atlas [here](https://atlas.hashicorp.com/joshfng/boxes/railsbox/)

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
