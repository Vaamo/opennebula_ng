#
# Cookbook Name:: opennebula_ng
# Attributes:: network
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

default['opennebula_ng']['interfaces']['br0']['dns-nameservers'] = '8.8.8.8'
default['opennebula_ng']['interfaces']['br0']['dns-search'] = nil
