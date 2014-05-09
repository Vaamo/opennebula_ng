#
# Cookbook Name:: opennebula_ng
# Recipe:: sunstone
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
  action [:enable, :start]
end
