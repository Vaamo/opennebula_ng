#
# Cookbook Name:: opennebula_ng
# Attributes:: one_auth
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

# Set shared passwords between all opennebula hosts for serveradmin and oneadmin
default['opennebula_ng']['one_auth']['oneadmin']['id'] = 0
default['opennebula_ng']['one_auth']['oneadmin']['password'] = nil
default['opennebula_ng']['one_auth']['serveradmin']['id'] = 1
default['opennebula_ng']['one_auth']['serveradmin']['password'] = nil

# Configure oneadmin home directory and the auth_file
default['opennebula_ng']['one_auth']['oneadmin']['home'] = '/var/lib/one'
default['opennebula_ng']['one_auth']['oneadmin']['auth_file'] = '/var/lib/one/.one/one_auth'

# Set ssh keypair for oneadmin user (as each opennebula machine needs to be able to connect to each other host)
default['opennebula_ng']['one_auth']['oneadmin']['id_rsa'] = nil
default['opennebula_ng']['one_auth']['oneadmin']['id_rsa.pub'] = nil
