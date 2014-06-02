#
# Cookbook Name:: opennebula_ng
# Recipe:: node
#
# Copyright (C) 2014 Chris Aumann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

package 'opennebula-node'
package 'bridge-utils'

# Network configuration, according to attributes
template '/etc/network/interfaces' do
  owner 'root'
  group 'root'
  mode 00644
  source 'interfaces.erb'
  variables interfaces: node['opennebula_ng']['interfaces']
end

service 'network' do
  # Use ifdown $interface && ifup $interface for each configured interface
  restart_command node['opennebula_ng']['interfaces'].keys.map { |interface| "ifdown #{interface} && ifup #{interface}" }.join('; ')
  supports   restart: true
  action     :nothing
  subscribes :restart, 'template[/etc/network/interfaces]'
end

# QEMU configuration
file '/etc/libvirt/qemu.conf' do
  user  'root'
  group 'root'
  mode  00600
  content <<-CONTENT
user  = "oneadmin"
group = "oneadmin"
dynamic_ownership = 0
  CONTENT
end

service 'libvirt-bin' do
  provider   Chef::Provider::Service::Upstart
  supports   restart: true, reload: true
  action     :nothing
  subscribes :restart, 'file[/etc/libvirt/qemu.conf]'
end
