#
# Cookbook Name:: opennebula_ng
# Attributes:: network
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

# ipv4
default['opennebula_ng']['interfaces']['br0']['inet']['type'] = 'static'
default['opennebula_ng']['interfaces']['br0']['inet']['address'] = nil
default['opennebula_ng']['interfaces']['br0']['inet']['network'] = nil
default['opennebula_ng']['interfaces']['br0']['inet']['netmask'] = nil
default['opennebula_ng']['interfaces']['br0']['inet']['broadcast'] = nil
default['opennebula_ng']['interfaces']['br0']['inet']['gateway'] = nil

default['opennebula_ng']['interfaces']['br0']['inet']['bridge_ports'] = 'eth0'
default['opennebula_ng']['interfaces']['br0']['inet']['bridge_fd'] = 9
default['opennebula_ng']['interfaces']['br0']['inet']['bridge_hello'] = 2
default['opennebula_ng']['interfaces']['br0']['inet']['bridge_maxage'] = 12
default['opennebula_ng']['interfaces']['br0']['inet']['bridge_stp'] = 'off'

default['opennebula_ng']['interfaces']['br0']['inet']['dns-nameservers'] = nil
default['opennebula_ng']['interfaces']['br0']['inet']['dns-search'] = nil

# ipv6
default['opennebula_ng']['interfaces']['br0']['inet6']['type'] = 'static'
default['opennebula_ng']['interfaces']['br0']['inet6']['address'] = nil
default['opennebula_ng']['interfaces']['br0']['inet6']['netmask'] = nil
default['opennebula_ng']['interfaces']['br0']['inet6']['gateway'] = nil
