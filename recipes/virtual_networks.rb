#
# Cookbook Name:: opennebula_ng
# Recipe:: virtual_networks
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
require 'tempfile'


# Create virtual networks
node['opennebula_ng']['virtual_networks'].each do |name, config|
  tempfile = Tempfile.new(%w(opennebula .one))

  execute "onevnet create #{tempfile.path}" do
    env 'ONE_AUTH' => node['opennebula_ng']['one_auth']
    action :nothing
  end

  # Generate config file
  ruby_block "generate virtual network config file (#{name})" do
    block do
      tempfile.write(%/NAME = "#{name}"\n/)
      config.each do |key, value|
        Array(value).each do |v|
          tempfile.write(%/#{key.upcase} = #{v}\n/)
        end
      end
      tempfile.close
      Chef::Log.info("Created temporary file with virtual network configuration in #{tempfile.path}")
    end

    notifies :run, "execute[onevnet create #{tempfile.path}]"

    # Do not execute if this datastore is already is existent
    not_if "ONE_AUTH=#{node['opennebula_ng']['one_auth']} onevnet list --csv |grep -q '#{name}'"
  end
end
