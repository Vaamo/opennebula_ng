#
# Cookbook Name:: opennebula_ng
# Recipe:: virtual_networks
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

# Create virtual networks
node['opennebula_ng']['virtual_networks'].each do |name, config|
  tempfile = Tempfile.new(%w(opennebula .one))

  execute "onevnet create #{tempfile.path}" do
    env 'ONE_AUTH' => node['opennebula_ng']['one_auth'],
        'HOME' => node['opennebula_ng']['one_home']
    action :nothing
  end

  # Generate config file
  ruby_block "generate virtual network config file (#{name})" do
    block do
      tempfile.write(%(NAME = "#{name}"\n))
      config.each do |key, value|
        Array(value).each do |v|
          tempfile.write(%(#{key.upcase} = #{v}\n))
        end
      end
      tempfile.close
      Chef::Log.info("Created temporary file with virtual network configuration in #{tempfile.path}")
    end

    notifies :run, "execute[onevnet create #{tempfile.path}]"

    # Do not execute if this virtual network is already is existent
    not_if ["ONE_AUTH=#{node['opennebula_ng']['one_auth']}",
            "HOME=#{node['opennebula_ng']['one_home']}",
            "onevnet list --csv |grep -q '#{name}'"].join(' ')
  end
end
