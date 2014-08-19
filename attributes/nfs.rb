#
# Cookbook Name:: opennebula_ng
# Attributes:: nfs
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

# Network to export NFS directories to, defaults to all hosts
default['opennebula_ng']['nfs']['network'] = '*'

# NFS fsid. Must be unique
default['opennebula_ng']['nfs']['fsid'] = 1

# Hostname/IP of the NFS server (usually the frontend machine)
default['opennebula_ng']['nfs']['server'] = nil
