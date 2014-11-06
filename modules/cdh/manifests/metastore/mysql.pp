class cdh::metastore::mysql (
  $mysqluser         = '',
  $mysqlpasswordhash = '',
)
{

  class { '::mysql::server':
    root_password    => 'root123',
    service_enabled  => true,
    override_options => { 'mysqld' => { 'max_connections' => '1024' } }
  }

  ->

  package { ['mysql-connector-java']:
    ensure => present,
  }

  ->

  mysql::db { 'metastore':
    user     => 'metastoreuser',
    password => 'secret',
  #  host     => 'master.puppetlabs.vm',
    sql      => '/usr/lib/hive/scripts/metastore/upgrade/mysql/hive-schema-0.13.0.mysql.sql',
  }

  ->
  
  file { '/usr/lib/hive/lib/mysql-connector-java.jar':
    ensure => 'link',
    target => '/usr/share/java/mysql-connector-java.jar',
  }

  ->
   
  mysql_user { "${mysqluser}@localhost":
    ensure        => 'present',
    password_hash => $mysqlpasswordhash,
  }

  ->

  mysql_grant { "${mysqluser}@localhost/metastore":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => 'metastore.*',
    user       => "${mysqluser}@localhost",
  }

}
