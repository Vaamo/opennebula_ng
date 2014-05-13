#
# Cookbook Name:: opennebula_ng
# Attributes:: nfs
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

# Network to export NFS directories to, defaults to all hosts
default['opennebula_ng']['nfs']['network'] = '*'

# NFS fsid. Must be unique
default['opennebula_ng']['nfs']['fsid'] = 1

# Hostname/IP of the NFS server (usually the frontend machine)
default['opennebula_ng']['nfs']['server'] = nil
