#
# Cookbook Name:: opennebula_ng
# Attributes:: mysql
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

# Default mysql database settings
default['opennebula_ng']['mysql']['server']  = 'localhost'
default['opennebula_ng']['mysql']['port']    = 3306
default['opennebula_ng']['mysql']['user']    = 'oneadmin'
default['opennebula_ng']['mysql']['passwd']  = 'oneadmin'
default['opennebula_ng']['mysql']['db_name'] = 'opennebula'

# Listen on all interfaces by default
default['mysqld']['my.cnf']['mysqld']['bind-address'] = '0.0.0.0'

# Settings required by Galera
default['mysqld']['my.cnf']['mysqld']['wsrep_provider'] = '/usr/lib/galera/libgalera_smm.so'
default['mysqld']['my.cnf']['mysqld']['wsrep_cluster_address'] = 'gcomm://localhost'
default['mysqld']['my.cnf']['mysqld']['binlog_format'] = 'ROW'
default['mysqld']['my.cnf']['mysqld']['default_storage_engine'] = 'InnoDB'
default['mysqld']['my.cnf']['mysqld']['innodb_autoinc_lock_mode'] = 2
default['mysqld']['my.cnf']['mysqld']['innodb_doublewrite'] = 1
default['mysqld']['my.cnf']['mysqld']['query_cache_size'] = 0
