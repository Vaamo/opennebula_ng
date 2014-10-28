#
# Cookbook Name:: opennebula_ng
# Recipe:: sunstone
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

package 'opennebula'
package 'opennebula-sunstone'

# Allow oneadmin (created by opennebula package) user to ssh into this machine
execute 'cp -a /var/lib/one/.ssh/id_rsa.pub /var/lib/one/.ssh/authorized_keys' do
  not_if 'test -s /var/lib/one/.ssh/authorized_keys'
end

# Setup ssh configuration for oneadmin user
file '/var/lib/one/.ssh/config' do
  owner 'oneadmin'
  group 'oneadmin'
  mode  00600
  content <<-CONTENT
Host *
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
  CONTENT
end

# Enable and start the web frontend
service 'opennebula-sunstone' do
  # Sunstone doesn't support "status", so we need to look for the right thing in the process table
  pattern 'sunstone-server'

  # Do not automatically enable/start sunstone, as OpenNebula doesn't support active-active
  # deployments. Only start it on the current master
  if node['opennebula_ng']['active']
    action [:enable, :start]
  else
    action [:disable]
  end
end
