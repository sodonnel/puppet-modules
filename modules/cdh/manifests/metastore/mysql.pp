class cdh::metastore::mysql (
  $mysqluser         = '',
  $mysqlpasswordhash = '',
)
{

  if $cdh_version  =~ /^5\.3/ {
    $hive_version = '0.13.0'
  }  
  elsif $cdh_version  =~ /^5\.(4|5|6|7|8|9|10|11|12|13|14|15)/ {
    $hive_version = '1.1.0'
  }

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
    sql      => "/usr/lib/hive/scripts/metastore/upgrade/mysql/hive-schema-${hive_version}.mysql.sql",
    cwd => "/usr/lib/hive/scripts/metastore/upgrade/mysql",
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

  mysql_grant { "${mysqluser}@localhost/metastore.*":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => 'metastore.*',
    user       => "${mysqluser}@localhost",
  }

  ->

  ### Setup for Oozie after here

  
  mysql::db { 'oozie':
    user     => 'oozieuser',
    password => 'secret',
  }

  ->
   
  mysql_grant { "${mysqluser}@localhost/oozie.*":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => 'oozie.*',
    user       => "${mysqluser}@localhost",
  }

  ->

  mysql::db { 'sentry':
    user     => 'sentry',
    password => 'sentry',
  }

  ->
   
  mysql_grant { "${mysqluser}@localhost/sentry.*":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => 'sentry.*',
    user       => "${mysqluser}@localhost",
  }

}
