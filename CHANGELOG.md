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
