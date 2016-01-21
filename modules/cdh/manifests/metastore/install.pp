class cdh::metastore::install {

  package { ['hive-metastore', 'hive-server2']:
    ensure => present,
  }

}
