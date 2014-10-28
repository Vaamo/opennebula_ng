#
# Cookbook Name:: opennebula_ng
# Recipe:: lvm
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

require 'tempfile'

package 'lvm2'

# Add oneadmin user to disk group
group 'disk' do
  members 'oneadmin'
  append  true
  action  :modify
end

# Create datastores
if node['opennebula_ng']['active']
  node['opennebula_ng']['lvm']['datastores'].each do |name, config|
    tempfile = Tempfile.new(%w(opennebula .conf))

    execute "onedatastore create #{tempfile.path}" do
      env 'ONE_AUTH' => node['opennebula_ng']['one_auth']['oneadmin']['auth_file'],
          'HOME' => node['opennebula_ng']['one_auth']['oneadmin']['home']
      action :nothing
    end

    # Generate config file
    ruby_block "generate datastore config file (#{name})" do
      block do
        tempfile.write(%(NAME = "#{name}"\n))
        config.each do |key, value|
          tempfile.write(%(#{key.upcase} = "#{value}"\n))
        end
        tempfile.close
        Chef::Log.info("Created temporary file with datastore configuration in #{tempfile.path}")
      end

      notifies :run, "execute[onedatastore create #{tempfile.path}]"

      # Do not execute if this datastore is already is existent
      not_if ["ONE_AUTH=#{node['opennebula_ng']['one_auth']['oneadmin']['auth_file']}",
              "HOME=#{node['opennebula_ng']['one_auth']['oneadmin']['home']}",
              "onedatastore list --csv |grep -q '#{name}'"].join(' ')
    end
  end
end

# Only allow physical HDs, because virtual machine PVs
# provoke "duplicate UUID" errors  when present
lvm_conf = Chef::Util::FileEdit.new('/etc/lvm/lvm.conf')
lvm_conf.search_file_replace_line(/^\s*filter/, %(    filter = [ "a|^/dev/hd.*|", "a|^/dev/sd.*|", "r/.*/" ]))
lvm_conf.write_file
