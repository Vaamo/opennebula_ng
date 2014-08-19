#
# Cookbook Name:: opennebula_ng
# Attributes:: lvm
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

# Add LVM datastores
# Format:
#   "lvm #{node['hostname']}" => {
#     DS_MAD: 'lvm',
#     TM_MAD: 'lvm',
#     DISK_TYPE: 'BLOCK',
#     VG_NAME: 'vg-one',
#     BRIDGE_LIST: node['hostname'],
#   }
default['opennebula_ng']['lvm']['datastores'] = {}
