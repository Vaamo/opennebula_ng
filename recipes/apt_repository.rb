#
# Cookbook Name:: opennebula_ng
# Recipe:: apt_repository
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

package 'lsb-release'

apt_repository 'opennebula' do
  case node['platform']
  when 'debian'
    # We need the mayor release number (e.g. 7)
    uri "http://downloads.opennebula.org/repo/4.12/Debian/#{node['lsb']['release'].to_i}"
  when 'ubuntu'
    uri "http://downloads.opennebula.org/repo/4.12/Ubuntu/#{node['lsb']['release']}"
  else
    Chef::Log.fatal!("Your platform (#{node['platform']}) is not supported.")
  end

  distribution 'stable'
  components %w(opennebula)
  key 'http://downloads.opennebula.org/repo/Debian/repo.key'
end
