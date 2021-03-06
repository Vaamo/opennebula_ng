#
# Cookbook Name:: opennebula_ng
# Recipe:: register_nodes
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

if node['opennebula_ng']['active']
  node['opennebula_ng']['nodes'].each do |nodename, config|
    # Translate argument hash to "--key value"
    arguments = config.map { |key, value| "--#{key} #{value}" }.join(' ')

    execute "onehost create #{nodename} #{arguments}" do
      env 'ONE_AUTH' => node['opennebula_ng']['one_auth']['oneadmin']['auth_file'],
          'HOME' => node['opennebula_ng']['one_auth']['oneadmin']['home']

      # Do not execute if this node is already is existent
      not_if ["ONE_AUTH=#{node['opennebula_ng']['one_auth']['oneadmin']['auth_file']}",
              "HOME=#{node['opennebula_ng']['one_auth']['oneadmin']['home']}",
              "onehost list --csv |grep #{nodename} -q"].join(' ')
    end
  end
end
