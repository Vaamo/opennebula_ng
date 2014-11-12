# opennebula\_ng cookbook

A cookbook for managing [OpenNebula](http://opennebula.org/) via the Chef configuration management tool.

## Supported Platforms

* Debian
* Ubuntu

## Quickstart

To setup a minimal configuration, standalone OpenNebula server, set the following attributes to configure your network

```ruby
node['opennebula_ng']['interfaces']['br0']['type'] = 'inet static'
node['opennebula_ng']['interfaces']['br0']['address'] = '192.168.1.100'
node['opennebula_ng']['interfaces']['br0']['network'] = '192.168.1.0'
node['opennebula_ng']['interfaces']['br0']['netmask'] = '255.255.255.0'
node['opennebula_ng']['interfaces']['br0']['broadcast'] = '192.168.1.255'
node['opennebula_ng']['interfaces']['br0']['gateway'] = '192.168.1.1'
```

And run the following recipes:

* default
* sunstone
* node
* register\_nodes


This will do the following things

* Install the Sunstone frontend
* Configure the network, add OpenNebula bridge
* Register the current host as an OpenNebula node

You should be able to connect to your new OpenNebula installation using `http://yourhost.com:9869`


## Recipes

### default

The default recpe just includes the `apt_repository` recipe


### apt\_repository

This recipe sets up the official OpenNebula PPA for Ubuntu (stable)


### sunstone

This recipe installs and configures the sunstone frontend.

* Installs opennebula and opennebula-sunstone packages
* Takes care of SSH and authorized\_keys configuration


### node

This recipe turns your machine into an opennebula node

* Configures networking according to node attributes (DANGER: touches `/etc/network/interfaces`)
* Configures the OpenNebula bridge interface
* Configures qEMU
* Configures libvirt

*MAKE SURE* you configure the following attributes (e.g. create one file for each node in your
wrapper cookbooks attribute dir, e.g. `attributes/myhost1.rb`)

```ruby
if node.name == 'myhost1'
  node['opennebula_ng']['interfaces']['br0']['type'] = 'inet static'
  node['opennebula_ng']['interfaces']['br0']['address'] = '192.168.1.100'
  node['opennebula_ng']['interfaces']['br0']['network'] = '192.168.1.0'
  node['opennebula_ng']['interfaces']['br0']['netmask'] = '255.255.255.0'
  node['opennebula_ng']['interfaces']['br0']['broadcast'] = '192.168.1.255'
  node['opennebula_ng']['interfaces']['br0']['gateway'] = '192.168.1.1'

  node['opennebula_ng']['interfaces']['br0']['bridge_ports'] = 'eth0'
  node['opennebula_ng']['interfaces']['br0']['bridge_fd'] = 9
  node['opennebula_ng']['interfaces']['br0']['bridge_hello'] = 2
  node['opennebula_ng']['interfaces']['br0']['bridge_maxage'] = 12
  node['opennebula_ng']['interfaces']['br0']['bridge_stp'] = 'off'
end
```

You can also configure additional interfaces, if required

```ruby
node['opennebula_ng']['interfaces']['br1']['type'] = 'inet static'
node['opennebula_ng']['interfaces']['br1']['address'] = '10.0.0.100'
node['opennebula_ng']['interfaces']['br1']['network'] = '10.0.0.0'
node['opennebula_ng']['interfaces']['br1']['netmask'] = '255.255.255.0'
node['opennebula_ng']['interfaces']['br1']['broadcast'] = '10.0.0.255'

node['opennebula_ng']['interfaces']['br1']['bridge_ports'] = 'eth1'
node['opennebula_ng']['interfaces']['br1']['bridge_fd'] = 9
node['opennebula_ng']['interfaces']['br1']['bridge_hello'] = 2
node['opennebula_ng']['interfaces']['br1']['bridge_maxage'] = 12
node['opennebula_ng']['interfaces']['br1']['bridge_stp'] = 'off'
```

### mariadb\_server

Configures OpenNebula to use a MariaDB backend.

Adjust the following attributes in case they are different from the defaults:

```ruby
# Default mysql database settings
node['opennebula_ng']['mysql']['server']  = 'localhost'
node['opennebula_ng']['mysql']['port']    = 0
node['opennebula_ng']['mysql']['user']    = 'oneadmin'
node['opennebula_ng']['mysql']['passwd']  = 'oneadmin'
node['opennebula_ng']['mysql']['db_name'] = 'opennebula'
```

Make sure you set a root password (This password will also be used for the `debian-sys-maint` user,
in case you use Debian/Ubuntu.

```ruby
node['mysqld']['root_password'] = 'get_me_from_encrypted_data_bag_maybe?'
```

Set the wsrep ssh auth, for example, use the root user which password we just specified:

```ruby
node['mysqld']['my.cnf']['mysqld']['wsrep_sst_auth'] = "root:#{node['mysqld']['root_password']}"
```

In case you have multiple interfaces, you might also want to specify the IP of the interface the
replication should use

```rubt
node['mysqld']['my.cnf']['mysqld']['wsrep_node_address'] = 'eth1'
```

In case you use more than one mariadb galera node, set this attribute to include all galera nodes
in your cluster

```ruby
node['mysqld']['my.cnf']['mysqld']['wsrep_cluster_address'] = 'gcomm://node1,node2,node3'
```

Its recommended to keep one Galera node on each physical cluster (as virtual machines), and then
default each machine to connect to the one their hosting. This can be done like this:

```ruby
# Connect to different clusters
if node.name == 'node1'
  default['opennebula_ng']['mysql']['server']  = 'galera.node.on.host1'
elsif node.name == 'node2'
  default['opennebula_ng']['mysql']['server']  = 'galera.node.on.host2'
else
  default['opennebula_ng']['mysql']['server']  = 'galera.node.on.host1'
end
```


### mariadb\_galera\_init

Use this cookbook if you want to initialize a new clusters first node:

```bash
sudo chef-client --once -o 'recipe[opennebula_ng::mariadb_galera_init]'
```

You can also include it (if required) in a `mariadb_galera_init` cookbook in your wrapper cookbook

```ruby
include_recipe 'opennebula_ng::mariadb_galera_init'
```

This cookbook just calls `mysqld::mariadb_galera_init`. Having it here is useful, as we set some
attributes which are not available when calling the mysqld recipe directly.

### mariadb\_client

This recipe configures the `/etc/one/oned.conf` configuration file on the servers to connect to the
mariadb cluster specified in the arguments from the mariadb\_server recipe.

*Note: If those values are changed, the file is not automatically updated. This is due to a bug with
multiline regular expressions. See `recipes/mariadb_client.rb` for details*


### register\_nodes

This recipe registers your hosts at oned.

The configuration is set via attributes, and supports all parameters that `onehost` supports.

The default is to register the node chef is currently running on, using kvm

```ruby
# You can add all your nodes centrally here
node['opennebula_ng']['nodes'] = {
  myhost1: { im: 'kvm', vm: 'kvm', net: 'dummy' },
  myhost2: { im: 'kvm', vm: 'kvm', net: 'dummy' },
  myhost3: { im: 'kvm', vm: 'kvm', net: 'dummy' },
}
```


### virtual\_networks

This recipe registers virtual networks using `onenet`.

You can specify your network configuration using the following attributes. Both `fixed` and `ranged`
networks are supported.

```ruby
node['opennebula_ng']['virtual_networks'] = {
  frontnet_dualstack: {
    BRIDGE: 'br0',
    GATEWAY: '192.168.1.1',
    NETWORK_MASK: '255.255.255.0',
    NETWORK_ADDRESS: '192.168.1.0',
    DNS: '208.67.222.222 208.67.220.220',
    AR: {
      TYPE: 'IP4_6',
      IP: '192.168.100.1',
      GLOBAL_PREFIX: '2a00:abcd:1000:f000::',
      SIZE: 100,
    }
  },
  backnet_ipv4: {
    BRIDGE: 'br1',
    NETWORK_MASK: '255.255.255.0',
    NETWORK_ADDRESS: '10.0.0.0',
    AR: {
      TYPE: 'IP4',
      IP: '10.0.0.100',
      SIZE: 10,
    }
  },
}
```

*Note: If you later add more addresses to an existing network, the settings are not automatically
updated on the nodes. The recipe skips creating a network if the network already exists.*

### lvm

A recipe to configure LVM datastores.

* Installs and configures lvm packages
* Creates datastores according to attributes

You can configure the datastores using the following attributes:

```ruby
node['opennebula_ng']['lvm']['datastores'] = {
  'my datastore' => {
    DS_MAD: 'lvm',
    TM_MAD: 'lvm',
    DISK_TYPE: 'BLOCK',
    VG_NAME: 'vg-one',
    BRIDGE_LIST: node['hostname'], # Add all hostnames of hosts accessing this datastore
  }
}
```


### nfs\_server

This recipe configures the host to be a NFS server. It can be configured using the following
attributes:

```ruby
# Network to export NFS directories to, defaults to all hosts
node['opennebula_ng']['nfs']['network'] = '*' # or a network like e.g. '10.0.0.0/24'

# NFS fsid. Must be unique
node['opennebula_ng']['nfs']['fsid'] = 1

# Hostname/IP of the NFS server (usually the frontend machine)
node['opennebula_ng']['nfs']['server'] = 'myhost1'
```


### nfs\_client

Configures the host to be an NFS client, mouting `/var/lib/one` from the server stored in
`node['opennebula_ng']['nfs']['server']`


### one\_auth

Configures the auth tokens in `/var/lib/one/.one`. When using a shared database, but not a shared
`/var/lib/one/.one` directory, they need to be in sync between all servers.

You can set the shared items using the following attributes:

```ruby
# Set shared passwords between all opennebula hosts for serveradmin and oneadmin
node['opennebula_ng']['one_auth']['oneadmin']['password'] = 'password_from_encrypted_data_bag_maybe?'
node['opennebula_ng']['one_auth']['serveradmin']['password'] = 'another_password'
```

You can also set the ssh keypair (as every OpenNebula host needs to be able to connect to the
others, using the "oneadmin" user).

Hint: You can generate a keypair using the `ssh-keygen` command.

```ruby
node['opennebula_ng']['one_auth']['oneadmin']['id_rsa'] = "-----BEGIN RSA PRIVATE KEY-----\nMIIE..."
node['opennebula_ng']['one_auth']['oneadmin']['id_rsa.pub'] = 'ssh-rsa AAAA...'
```

*NOTE: This recipe assumes that the oneuser has id 0, and serveradmin the id 1. This is the default.
If you have them set to something else, make sure to adjust the id attributes!*

```ruby
node['opennebula_ng']['one_auth']['oneadmin']['id'] = 0
node['opennebula_ng']['one_auth']['serveradmin']['id'] = 1
```

You can also configure (if needed) the oneadmin's home directory as well as the `one_auth` file that
will be used:

```ruby
node['opennebula_ng']['one_auth']['oneadmin']['home'] = '/var/lib/one'
node['opennebula_ng']['one_auth']['oneadmin']['auth_file'] = '/var/lib/one/.one/one_auth'
```

## Notes

Please be aware, that you probably want a reverse proxy like [nginx](http://nginx.org) incl. SSL
before you deploy OpenNebula to your production servers.

You can easily do this e.g. using the
[certificate](https://github.com/atomic-penguin/cookbook-certificate) and
[nginx](https://github.com/miketheman/nginx) cookbooks.



## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Chris Aumann (<me@chr4.org>)
| **Copyright:**       | Copyright (c) 2014 Vaamo Finanz AG
| **License:**         | Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
