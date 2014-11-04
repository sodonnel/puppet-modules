class cdh51metastore::mysqlserver {

  class { '::mysql::server':
    root_password    => 'root123',
    service_enabled  => true,
    override_options => { 'mysqld' => { 'max_connections' => '1024' } }
  }

  mysql::db { 'metastore':
    user     => 'metastoreuser',
    password => 'secret',
  #  host     => 'master.puppetlabs.vm',
    sql        => '/tmp/metastore_create.sql',
    require => File['/tmp/metastore_create.sql'],
  }

  file { "/tmp/metastore_create.sql":
    ensure => present,
    source => "puppet:///modules/cdh51metastore/metastore_create.sql",
  }

 #  mysql_user { 'bob@localhost':
 #   ensure                   => 'present',
 #   max_connections_per_hour => '60',
 #   max_queries_per_hour     => '120',
 #   max_updates_per_hour     => '120',
 #   max_user_connections     => '10',
 # }

 # mysql_grant { 'bob@localhost/statedb.states':
 #   ensure     => 'present',
 #   options    => ['GRANT'],
 #   privileges => ['ALL'],
 #   table      => 'statedbl.states',
 #   user       => 'bob@localhost',
 # }

}
