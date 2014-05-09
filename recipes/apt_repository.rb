#
# Cookbook Name:: opennebula_ng
# Recipe:: apt_repository
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

package 'lsb-release'

apt_repository 'opennebula' do
    case node['platform']
    when 'debian'
      # We need the mayor release number (e.g. 7)
      uri "http://downloads.opennebula.org/repo/Debian/#{node['lsb']['release'].to_i}"
    when 'ubuntu'
      uri "http://downloads.opennebula.org/repo/Ubuntu/#{node['lsb']['release']}"
    else
      Chef::Log.fatal!("Your platform (#{node['platform']}) is not supported.")
    end

    distribution 'stable'
    components %w(opennebula)
    key 'http://downloads.opennebula.org/repo/Debian/repo.key'
end
