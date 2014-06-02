#
# Cookbook Name:: opennebula_ng
# Recipe:: register_nodes
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

node['opennebula_ng']['nodes'].each do |nodename, config|
  # Translate argument hash to "--key value"
  arguments = config.map { |key, value| "--#{key} #{value}" }.join(' ')

  execute "onehost create #{nodename} #{arguments}" do
    env 'ONE_AUTH' => node['opennebula_ng']['one_auth']

    # Do not execute if this node is already is existent
    not_if "ONE_AUTH=#{node['opennebula_ng']['one_auth']} onehost list --csv |grep #{nodename} -q"
  end
end
