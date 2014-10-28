#
# Cookbook Name:: opennebula_ng
# Recipe:: mariadb_galera
#
# Copyright 2014, Vaamo Finanz AG
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# /etc/one/oned.conf is part of the package "opennebula".
# Make sure it's installed
package 'opennebula'

# Configure OpenNebula to use MariaDB
# Exchange DB = [] configuration in /etc/one/oned.conf with settings in attributes
#
# TODO: Somehow the regex doesn't match multiline expressions, even when using /m
oned_conf = Chef::Util::FileEdit.new('/etc/one/oned.conf')
oned_conf.search_file_replace_line(/^\s*DB\s*=\s*\[.*?\]/m, %(DB = [ backend = "mysql",
  server  = "#{node['opennebula_ng']['mysql']['server']}",
  port    = #{node['opennebula_ng']['mysql']['port']},
  user    = "#{node['opennebula_ng']['mysql']['user']}",
  passwd  = "#{node['opennebula_ng']['mysql']['passwd']}",
  db_name = "#{node['opennebula_ng']['mysql']['db_name']}" ]
))
oned_conf.write_file

service 'opennebula' do
  # Disable service by default (on passive nodes)
  action = :disable

  # Enable service on active nodes, restart service if config file was changed
  if node['opennebula_ng']['active']
    action = :enable
    action = [:enable, :restart] if oned_conf.file_edited?
  end

  action action
end
