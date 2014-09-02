#
# Cookbook Name:: opennebula_ng
# Recipe:: node
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
