#
# Cookbook Name:: opennebula_ng
# Recipe:: nfs_client
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


package 'nfs-common'

mount '/var/lib/one' do
  fstype  'nfs'
  device  "#{node['opennebula_ng']['nfs']['server']}:/var/lib/one"
  options 'soft,intr,rsize=8192,wsize=8192,noauto'
  pass    0
  action  [:mount, :enable]

  only_if { node['opennebula_ng']['nfs']['server'] }
end
