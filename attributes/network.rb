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

default['opennebula_ng']['interfaces']['br0']['type'] = 'inet static'
default['opennebula_ng']['interfaces']['br0']['address'] = nil
default['opennebula_ng']['interfaces']['br0']['network'] = nil
default['opennebula_ng']['interfaces']['br0']['netmask'] = nil
default['opennebula_ng']['interfaces']['br0']['broadcast'] = nil
default['opennebula_ng']['interfaces']['br0']['gateway'] = nil

default['opennebula_ng']['interfaces']['br0']['bridge_ports'] = 'eth0'
default['opennebula_ng']['interfaces']['br0']['bridge_fd'] = 9
default['opennebula_ng']['interfaces']['br0']['bridge_hello'] = 2
default['opennebula_ng']['interfaces']['br0']['bridge_maxage'] = 12
default['opennebula_ng']['interfaces']['br0']['bridge_stp'] = 'off'

default['opennebula_ng']['interfaces']['br0']['dns-nameservers'] = nil
default['opennebula_ng']['interfaces']['br0']['dns-search'] = nil
