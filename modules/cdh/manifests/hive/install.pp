class cdh::hive::install {

  package { ['hive-metastore', 'hive-server2']:
    ensure => present,
  }

}
