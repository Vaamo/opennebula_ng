#
# Cookbook Name:: opennebula_ng
# Recipe:: nfs_server
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

package 'nfs-kernel-server'

nfs_export '/var/lib/one' do
  network node['opennebula_ng']['nfs']['network']
  writeable true
  sync true
  options ['no_subtree_check', 'root_squash', "fsid=#{node['opennebula_ng']['nfs']['fsid']}"]
end
