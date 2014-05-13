#
# Cookbook Name:: opennebula_ng
# Recipe:: nfs_client
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

package 'nfs-common'

mount '/var/lib/one' do
  fstype  'nfs'
  device  "#{node['opennebula_ng']['nfs']['server']}:/var/lib/one"
  options 'soft,intr,rsize=8192,wsize=8192,noauto'
  pass    0
  action  [:mount, :enable]

  only_if { node['opennebula_ng']['nfs']['server'] }
end
