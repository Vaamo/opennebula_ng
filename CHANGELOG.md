4.10.0
------

- Use OpenNebula 4.10 repositories. To upgrade, run `apt-get dist-upgrade` after deploying the
  cookbook. Make sure you also run the database migrations using `onedb upgrade`.

4.8.5
-----

- Support new address range (AR) syntax in `virtual_network` recipe
- Use --sha1 when changing password for serveradmin
- Deploy `id_rsa.pub` alongside `id_rsa`
- Do not automatically restart network configuration. This is problematic, as it cuts off virtual
  machines from their network bridges.

4.8.4
-----

- Fail hard when not using a valid network configration, instead of deploying an empty
  /etc/network/interfaces

4.8.3
-----

- Add `node['opennebula_ng']['active']` attribute, which defaults to false. On non-active opennebula
  hosts we won't add networks/storage/users and will disable oned, scheduler and sunstone services,
  as OpenNebula is not capable of running as an active-active environment due to caching issues.

Compatibility changes:
- Set `node['opennebula_ng']['active'] = true` on your currently active (master) host

4.8.2
-----

- Add one\_auth recipe, to set shared passwords for "oneadmin" and "serveradmin" users, as well as
  deploy ssh keys

Compatibility changes:
- Renamed `node['opennebula_ng']['one_auth']` attribtue to `node['opennebula_ng']['one_auth']['oneadmin']['auth_file']`
- Renamed `node['opennebula_ng']['one_home']` attribute to `node['opennebula_ng']['one_auth']['oneadmin']['home']`

4.8.1
-----

- Use mariadb galera by default

4.8.0
-----

- Upgrade to OpenNebula 4.8 packages

0.1.0
-----

- Initial release of opennebula\_ng
