#
# Cookbook Name:: opennebula_ng
# Recipe:: one_auth
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

# Deploy /var/lib/one/.one/ secrets (oneuser password)
execute 'Set oneuser passwd for serveradmin' do
  user 'oneadmin'
  command "oneuser passwd #{node['opennebula_ng']['one_auth']['serveradmin']['id']} #{node['opennebula_ng']['one_auth']['serveradmin']['password']}"
  action :nothing
end

# The password for the user oneadmin needs to be set before we change the one_auth file. Once the
# one_auth file is changed, it will be used to authenticate when using "oneuser" and will then fail
# if the password wasn't changed before.
execute 'Set oneuser passwd for oneadmin' do
  user 'oneadmin'
  command "oneuser passwd #{node['opennebula_ng']['one_auth']['oneadmin']['id']} #{node['opennebula_ng']['one_auth']['oneadmin']['password']}"
  only_if  { node['opennebula_ng']['one_auth']['oneadmin']['password'] }
end

%w(ec2_auth occi_auth oneflow_auth onegate_auth sunstone_auth).each do |file|
  file "/var/lib/one/.one/#{file}" do
    mode    00600
    user    'oneadmin'
    group   'oneadmin'
    content "serveradmin:#{node['opennebula_ng']['one_auth']['serveradmin']['password']}\n"
    notifies :run, 'execute[Set oneuser passwd for serveradmin]'
    only_if  { node['opennebula_ng']['one_auth']['serveradmin']['password'] }
  end
end

file '/var/lib/one/.one/one_auth' do
  mode    00600
  user    'oneadmin'
  group   'oneadmin'
  content "oneadmin:#{node['opennebula_ng']['one_auth']['oneadmin']['password']}\n"
  only_if  { node['opennebula_ng']['one_auth']['oneadmin']['password'] }
end

# Every opennebula host needs access to other hosts as the oneuser.
# Deploy /var/lib/one/.ssh/ keys and authorized keys.
file '/var/lib/one/.ssh/id_rsa' do
  mode    00600
  owner   'oneadmin'
  group   'oneadmin'
  content "#{node['opennebula_ng']['one_auth']['oneadmin']['id_rsa']}\n"
  only_if { node['opennebula_ng']['one_auth']['oneadmin']['id_rsa'] }
end

file '/var/lib/one/.ssh/authorized_keys' do
  mode    00644
  owner   'oneadmin'
  group   'oneadmin'
  content "#{node['opennebula_ng']['one_auth']['oneadmin']['id_rsa.pub']}\n"
  only_if { node['opennebula_ng']['one_auth']['oneadmin']['id_rsa.pub'] }
end
