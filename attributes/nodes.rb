#
# Cookbook Name:: opennebula_ng
# Attributes:: nodes
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

# List of worker nodes to register at oned
# Format:
#   nodename: { im: 'kvm', vm: 'kvm', net: 'dummy' }
#
# The default is adding the current host, using kvm
default['opennebula_ng']['nodes'] = { node['hostname'] => {im: 'kvm', vm: 'kvm', net: 'dummy'} }
